function hookScript(a)
  local file = io.open("Output.lua", "w+")

  local b, c, d, e, f = {}, {}, {}, 1, ""
  local outputted = "--[[\n\nLUAU Constant Dumper (Dumped @"..tostring(os.date())..")\n\n]]\n\nlocal Dumped = {\n"

  while true do
    local g = #a
    local j = 1
    for h, i in next, a do
      if b[a] == nil or j >= b[a] then
          if f ~= "" and f ~= "\n" and f ~= "\n\n" then
            if i ~= "" and i ~= "\n" and i ~= "\n\n" then
              if f ~= "true" and f ~= "false" then
                if string.find(f, "}", string.len(f)) then
                  if type(tonumber(f)) == "number" then
                    f = "  "..f..", -- "..tostring(h).." : "..tostring(i).."\n"
                    _G.Numbers = _G.Numbers + 1
                  elseif type(f) == "string" then
                    f = "  "..f..", -- "..tostring(h).." : "..tostring(i).."\n"
                    _G.Strings = _G.Strings + 1
                  end
                elseif not string.find(f, "\n", string.len(f)) then
                  if type(tonumber(f)) == "number" then
                    f = "  "..f..", -- "..tostring(h).." : "..tostring(i).."\n"
                    _G.Numbers = _G.Numbers + 1
                  elseif type(f) == "string" then
                    f = "  \""..f.."\", -- "..tostring(h).." : "..tostring(i).."\n"
                    _G.Strings = _G.Strings + 1
                  end
                end
              elseif f == "true" then
                f = "  "..f..",\n"
              elseif f == "false" then
                f = "  "..f..",\n"
              end
            end
          end

          table.insert(d, f)
          f = ""

          if type(i) == "number" then
            f = f..tonumber(i)
          elseif type(i) == "boolean" then
            f = f..tostring(i)
          elseif type(i) == "table" then
            f = f
            table.insert(c, a)
            table.insert(c, i)
            b[a] = j + 1
            break
          elseif type(i) == "string" then
            f = f..tostring(i)
          elseif type(i) == "function" then
            f = f..i
          end
      end

      j = j + 1
    end

    if #c > 0 then
      a = c[#c]
      c[#c] = nil
      e = b[a] == nil and e + 1 or e - 1
    else
      break
    end
  end

  table.insert(d, f)
  f = table.concat(d)

  outputted = outputted..f.."\n}\n\nfor i, v in next, Dumped do\n   print(i..\", \", v..\", \", type(v))\nend\n\n--[[\n\n   • Numbers dumped : "..tostring(_G.Numbers).."\n   • Strings dumped : "..tostring(_G.Strings).."\n\n]]"

  file:write(outputted)
end

return hookScript
