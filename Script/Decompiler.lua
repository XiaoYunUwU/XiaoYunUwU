local Decompiler = {}

Decompiler.Opcodes = {
  [0] = {Name = "MOVE"}, [1] = {Name = "LOADK"}, [2] = {Name = "LOADBOOL"}, [3] = {Name = "LOADNIL"},
  [4] = {Name = "GETUPVAL"}, [5] = {Name = "GETGLOBAL"}, [6] = {Name = "GETTABLE"}, [7] = {Name = "SETGLOBAL"},
  [8] = {Name = "SETUPVAL"}, [9] = {Name = "SETTABLE"}, [10] = {Name = "NEWTABLE"}, [11] = {Name = "SELF"},
  [12] = {Name = "ADD"}, [13] = {Name = "SUB"}, [14] = {Name = "MUL"}, [15] = {Name = "DIV"},
  [16] = {Name = "MOD"}, [17] = {Name = "POW"}, [18] = {Name = "UNM"}, [19] = {Name = "NOT"},
  [20] = {Name = "LEN"}, [21] = {Name = "CONCAT"}, [22] = {Name = "JMP"}, [23] = {Name = "EQ"},
  [24] = {Name = "LT"}, [25] = {Name = "LE"}, [26] = {Name = "TEST"}, [27] = {Name = "TESTSET"},
  [28] = {Name = "CALL"}, [29] = {Name = "TAILCALL"}, [30] = {Name = "RETURN"}, [31] = "FORLOOP",
  [32] = "FORPREP", [33] = "TFORLOOP", [34] = "SETLIST", [35] = "CLOSE", [36] = "CLOSURE", [37] = "VARARG",
  [187] = {Name = "LOAD_CONST_STR"}, [288] = {Name = "LOAD_STR"}, [161] = {Name = "JMP"}, [313] = {Name = "EQ_CONST"},
  [65] = {Name = "MOVE"}, [185] = {Name = "GETTABLE_S_CONST"}, [40] = {Name = "GETTABLE_S_PARAM"},
  [109] = {Name = "GETTABLE_R"}, [285] = {Name = "SETTABLE_S_CONST"}, [147] = {Name = "SETTABLE_S_RK"},
  [357] = {Name = "NEWTABLE"}, [196] = {Name = "SELF"}, [46] = {Name = "RETURN"}, [194] = {Name = "CLOSURE"},
  [183] = {Name = "CONCAT"}, [270] = {Name = "SETUPVAL"}, [41] = {Name = "GETUPVAL"}, [263] = {Name = "CALL"},
  [95] = {Name = "LOAD_FUNC_ENV"}, [377] = {Name = "LOAD_REG_FROM_UPVAL_OR_CONST"}, [61] = {Name = "JMP_IF_NOT_EQ_CONST"},
  [239] = {Name = "JMP_IF_FALSE"}, [364] = {Name = "JMP_IF_TRUE"}, [94] = {Name = "CALL_FROM_UPVAL"},
  [210] = {Name = "LOAD_GLOBAL_ENV"}, [246] = {Name = "LOAD_UDIM2"}, [93] = {Name = "LOAD_VECTOR2_OR_UDIM"},
  [195] = {Name = "CALL_NO_RETURN"}, [13] = {Name = "SETTABLE_S_RK"}, [35] = {Name = "SETTABLE_S_PARAM_RK"},
  [22] = {Name = "CALL"}, [12] = {Name = "SETTABLE_S_PARAM_RK"}, [8] = {Name = "LOAD_COLOR3"},
  [57] = {Name = "ADD_CONST"}, [2] = {Name = "SUB_CONST"}, [27] = {Name = "SETTABLE_S_RK"},
  [29] = {Name = "LOAD_GLOBAL_STR"}, [26] = {Name = "LOADK_EXT"}, [7] = {Name = "LOAD_GLOBAL_STR"},
  [4] = {Name = "LOAD_GLOBAL_STR"}, [14] = {Name = "LOAD_GLOBAL_STR"}, [18] = {Name = "LOADK_EXT"},
  [17] = {Name = "LOAD_INSTANCE"}, [24] = {Name = "GETTABLE_S_PARAM"}, [15] = {Name = "LOAD_NUM"},
  [21] = {Name = "LOAD_NUM"}, [6] = {Name = "LOAD_NUM"}, [3] = {Name = "LOAD_GLOBAL_STR"},
  [9] = {Name = "GETTABLE_S_CONST"}, [10] = {Name = "LOAD_NUM"}, [20] = {Name = "LOAD_NUM"},
  [205] = {Name = "CALL"}, [82] = {Name = "LOAD_UDIM"}
}

local function formatValue(val)
  local t = type(val)
  if t == "string" then
    return string.format("%q", val:gsub("\\", "\\\\"):gsub("\n", "\\n"):gsub("\r", "\\r"))
  elseif t == "table" then
    if not next(val) then return "{}" end
    local parts = {}
    for i, v in ipairs(val) do
      table.insert(parts, formatValue(v))
    end
    return "{" .. table.concat(parts, ", ") .. "}"
  elseif t == "boolean" then
    return tostring(val)
  else
    return tostring(val)
  end
end

local function formatOperand(op)
  if type(op) == "string" then return op end
  if type(op) == "number" then return tostring(op) end
  return "nil"
end

function Decompiler.decompileFunction(chunk, indent, funcName)
  local instructions = chunk[1]
  local constants = chunk[2] or {}
  local prototypes = chunk[4] or {}

  local registers = {}
  local upvalues = {}
  for i = 1, 50 do table.insert(upvalues, "upval" .. i) end
  local locals = {}
  local localCounter = 0

  local output = {}
  local processedLines = {}
  local blockIndents = {}

  local function write(str, lineNum)
    if lineNum and not processedLines[lineNum] then
      table.insert(output, {lineNum, string.rep("\t", blockIndents[lineNum] or indent) .. str})
      processedLines[lineNum] = true
    end
  end

  local function getConstant(index)
    return formatValue(constants[index])
  end

  local function getRK(val)
    if type(val) ~= "number" then return formatValue(val) end
    if val >= 256 then
      return getConstant(val - 256)
    end
    return registers[val] or ("_R[%d]"):format(val)
  end

  local function assignToRegister(regIndex, value, lineNum, isDeclaring)
    local varName
    isDeclaring = isDeclaring == nil and true or isDeclaring

    if locals[regIndex] then
      varName = locals[regIndex]
      write(string.format("%s = %s", varName, value), lineNum)
    else
      varName = "var" .. localCounter
      locals[regIndex] = varName
      write(string.format("local %s = %s", varName, value), lineNum)
      localCounter = localCounter + 1
    end
    registers[regIndex] = varName
  end

  local jumpSources = {}
  local jumpDests = {}
  for i, instr in ipairs(instructions) do
    if type(instr) ~= "table" then continue end
    local opcodeInfo = Decompiler.Opcodes[instr[1]]
    local opcodeName = opcodeInfo and (opcodeInfo.Name or opcodeInfo)
    if opcodeName and opcodeName:find("JMP") then
      local offset = (opcodeName == "JMP" and type(instr[3]) == "number") and instr[3] or (type(instr[4]) == "number" and instr[4])
      if type(offset) == 'number' then
        local target = i + offset + 1
        jumpDests[target] = (jumpDests[target] or 0) + 1
        jumpSources[i] = {target = target, type = "unconditional"}
      end
    elseif opcodeName and (opcodeName:find("EQ") or opcodeName:find("LT") or opcodeName:find("LE") or opcodeName:find("TEST")) then
      local nextInstr = instructions[i + 1]
      if nextInstr and Decompiler.Opcodes[nextInstr[1]] and Decompiler.Opcodes[nextInstr[1]].Name:find("JMP") then
        local offset = (Decompiler.Opcodes[nextInstr[1]].Name == "JMP" and type(nextInstr[3]) == "number") and nextInstr[3] or (type(nextInstr[4]) == "number" and nextInstr[4])
        if type(offset) == 'number' then
          local target = (i + 1) + offset + 1
          jumpDests[target] = (jumpDests[target] or 0) + 1
          jumpSources[i] = {target = target, type = "conditional"}
        end
      end
    end
      continue
  end

  local i = 1
  local currentIndent = indent
  while i <= #instructions do
    if processedLines[i] then i = i + 1 continue end
    local instr = instructions[i]
    if type(instr) ~= "table" or #instr < 1 then i = i + 1 continue end
    local opcodeNum, A, B, C, D, E, F, G, H = table.unpack(instr)
    local opcodeInfo = Decompiler.Opcodes[opcodeNum]
    local opcodeName = (opcodeInfo and (opcodeInfo.Name or opcodeInfo)) or "UNKNOWN_OP_" .. tostring(opcodeNum)
    blockIndents[i] = currentIndent
    local consumed = 1

    if opcodeName == "LOADK" or opcodeName == "LOAD_CONST_STR" or opcodeName == "LOADK_EXT" then
      assignToRegister(A, getConstant(B), i)
    elseif opcodeName == "LOAD_STR" then
      assignToRegister(A, formatValue(B), i)
    elseif opcodeName:find("LOAD_NUM") then
      assignToRegister(A, tostring(B), i)
    elseif opcodeName == "LOAD_INSTANCE" then
      assignToRegister(A, string.format("Instance.new(%q)", B), i)
    elseif opcodeName == "LOADBOOL" then
      assignToRegister(A, tostring(B == 1), i)
    elseif opcodeName == "LOADNIL" then
      for j = A, B do assignToRegister(j, "nil", i) end
    elseif opcodeName == "GETUPVAL" then
      assignToRegister(A, upvalues[B+1] or "upval" .. tostring(B+1), i, false)
    elseif opcodeName == "SETUPVAL" then
      write(string.format("%s = %s", upvalues[B+1] or "upval"..tostring(B+1), registers[A] or "R_" .. A), i)
    elseif opcodeName:find("GETTABLE") then
      local source = registers[B] or "_R["..B.."]"
      local key
      if opcodeName:find("_S_") then
        key = (opcodeName:find("_CONST")) and constants[C] or C
        if type(key) == 'string' and key:match("^[a-zA-Z_][a-zA-Z0-9_]*$") then
          assignToRegister(A, string.format("%s.%s", source, key), i, false)
        else
          assignToRegister(A, string.format("%s[%s]", source, formatValue(key)), i, false)
        end
      else
        assignToRegister(A, string.format("%s[%s]", source, registers[C]), i, false)
      end
    elseif opcodeName:find("SETTABLE") then
      local target = registers[A] or "_R["..A.."]"
      local key = (opcodeName:find("_S_")) and B or getRK(B)
      local val = getRK(C)
      if type(key) == 'string' and key:match("^[a-zA-Z_][a-zA-Z0-9_]*$") then
        write(string.format("%s.%s = %s", target, key, val), i)
      else
        write(string.format("%s[%s] = %s", target, formatValue(key), val), i)
      end
    elseif opcodeName == "MOVE" then
      assignToRegister(A, registers[B] or "_R["..B.."]", i, false)
    elseif opcodeName == "NEWTABLE" then
      assignToRegister(A, "{}", i)
    elseif opcodeName == "SELF" then
      local selfObj = registers[B] or "_R["..B.."]"
      local key = getRK(C)
      local methodName = tostring(key):gsub('"', '')
      registers[A] = string.format("%s:%s", selfObj, methodName)
      registers[A+1] = selfObj
    elseif opcodeName:find("CALL") then
      local func = registers[A] or "_R["..A.."]"
      local args = {}
      local numArgs = (B == 0) and (#registers - A) or (B - 1)
      for j = 1, numArgs do
        local arg = registers[A + j] or "nil"
        table.insert(args, arg)
      end
      local callStr = string.format("%s(%s)", func, table.concat(args, ", "))
      if C == 0 or C == 1 or opcodeName == "CALL_NO_RETURN" then
        write(callStr, i)
      else
        local numRets = C - 1
        if numRets == 1 then
          assignToRegister(A, callStr, i)
        else
          local rets = {}
          for j = 0, numRets - 1 do
            local varName = "var" .. localCounter
            local regIdx = A + j
            locals[regIdx] = varName
            registers[regIdx] = varName
            table.insert(rets, varName)
            localCounter = localCounter + 1
          end
          write(string.format("local %s = %s", table.concat(rets, ", "), callStr), i)
        end
      end
    elseif opcodeName:find("RETURN") then
      local rets = {}
      if B ~= 1 then
        for j = A, A + (B or 2) - 2 do table.insert(rets, registers[j] or "nil") end
      end
      write("return " .. table.concat(rets, ", "), i)
    elseif opcodeName:find("JMP_IF") or (opcodeName:find("EQ") and jumpSources[i]) then
      local condition
      if opcodeName:find("EQ") then
        local op = (instr[2] == 0) and "~=" or "=="
        local valB = (opcodeName == "EQ_CONST") and getConstant(B) or getRK(B)
        condition = string.format("%s %s %s", registers[instr[2]], op, valB)
      else
        condition = (opcodeName:find("FALSE")) and "not (" .. (registers[A] or "_R["..A.."]") .. ")" or (registers[A] or "_R["..A.."]")
      end
      write(string.format("if %s then", condition), i)
      currentIndent = currentIndent + 1
      consumed = (opcodeName:find("EQ")) and 2 or 1
    elseif opcodeName == "CLOSURE" then
      local protoIndex = B
      local func_name = funcName .. "_sub" .. protoIndex
      write(string.format("local %s = function(...)", func_name), i)
      local decompiledLines = Decompiler.decompileFunction(prototypes[protoIndex], currentIndent + 1, func_name)
      table.insert(output, {i, table.concat(decompiledLines, "\n")})
      write("end", i)
      assignToRegister(A, func_name, false, i)
    elseif opcodeName:find("CONCAT") then
      local parts = {}
      for j = B, C do table.insert(parts, registers[j] or "_R["..j.."]") end
      assignToRegister(A, table.concat(parts, " .. "), i, false)
    elseif opcodeName:find("JMP") then
      local target = jumpSources[i] and jumpSources[i].target
      if target and target < i then
        currentIndent = currentIndent - 1
        write("end", i)
      else
        write("else", i)
        currentIndent = currentIndent + 1
      end
    elseif opcodeName == "LOAD_UDIM2" then
      assignToRegister(A, string.format("UDim2.new(%s, %s, %s, %s)", tostring(B), tostring(C), tostring(D), tostring(E)), i)
    elseif opcodeName == "LOAD_COLOR3" then
      assignToRegister(A, string.format("Color3.new(%s, %s, %s)", tostring(B), tostring(C), tostring(D)), i)
    elseif opcodeName == "LOAD_VECTOR2_OR_UDIM" then
      assignToRegister(A, string.format("Vector2.new(%s, %s)", tostring(B), tostring(C)), i)
    else
      write(string.format("-- %s A=%s B=%s C=%s", opcodeName, tostring(A), tostring(B), tostring(C)), i)
    end

    i = i + consumed
      continue
  end

  table.sort(output, function(a, b) return a[1] < b[1] end)

  local lines = {}
  for _, v in ipairs(output) do
    table.insert(lines, v[2])
  end

  return lines
end

function Decompiler.start(scriptChunk)
    if not scriptChunk or type(scriptChunk) ~= "table" then
        warn("Decompiler.start: Null")
        return
    end

    local lines = Decompiler.decompileFunction(scriptChunk, 0, "Main")
    print("[Decompiler 输出]")
    print(table.concat(lines, "\n"))
end

return Decompiler