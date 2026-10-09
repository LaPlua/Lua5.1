-- ===== instrumentation prelude =====
local __realconcat = table.concat
local __seen = {}
local __order = 0
function __concat(t, sep, i, j)
    local r = __realconcat(t, sep, i, j)
    if type(r) == "string" and #r >= 5 and #r <= 100000 then
        local _, cnt = r:gsub("[^\32-\126]", "")
        if cnt / #r > 0.85 and not __seen[r] then
            __seen[r] = true
            __order = __order + 1
            print(("[[DEC %d len=%d]] %s"):format(__order, #r, (r:gsub("[^\32-\126]", "."))))
        end
    end
    return r
end

function __consts(t, cnt)
    local out = {}
    local n = cnt or #t
    for i = 1, n do
        local v = t[i]
        if v == nil then out[#out+1] = ("[%d]nil"):format(i)
        else
            local ty = type(v)
            if ty == "string" then out[#out+1] = ("[%d]S:%q"):format(i, v)
            elseif ty == "number" then out[#out+1] = ("[%d]N:%s"):format(i, tostring(v))
            elseif ty == "boolean" then out[#out+1] = ("[%d]B:%s"):format(i, tostring(v))
            else out[#out+1] = ("[%d]%s"):format(i, ty) end
        end
    end
    print("[[CONSTS " .. tostring(n) .. "]] " .. __realconcat(out, " | "))
end

function __dump(tag, s)
    if type(s) ~= "string" then print("[[", tag, "nonstring", type(s), "]]") return end
    local parts = {}
    for i = 1, #s do parts[i] = ("%02x"):format(s:byte(i)) end
    print(("[[%s len=%d]]%s"):format(tag, #s, __realconcat(parts)))
end

local __sdseen = {}
function __strlog(s)
    if type(s) == "string" and #s >= 1 and not __sdseen[s] then
        __sdseen[s] = true
        print(("[[STR]] %q"):format(s))
    end
end

function __mk(name)
    local t = {}
    setmetatable(t, {
        __index = function(_, k)
            if k == "__name" then return name end
            return __mk(name .. "." .. tostring(k))
        end,
        __call = function(_, ...) return __mk(name .. "()") end,
        __tostring = function() return name end,
        __add = function() return __mk(name .. "+") end,
        __sub = function() return __mk(name .. "-") end,
        __mul = function() return __mk(name .. "*") end,
        __div = function() return __mk(name .. "/") end,
        __mod = function() return __mk(name .. "%") end,
        __pow = function() return __mk(name .. "^") end,
        __unm = function() return __mk("-" .. name) end,
        __concat = function(a, b) return tostring(a) .. tostring(b) end,
        __eq = function() return false end,
        __lt = function() return false end,
        __le = function() return false end,
        __len = function() return 0 end,
        __newindex = function(t, k, v) rawset(t, k, v) end,
    })
    return t
end
