local M = {}

FLAG_DEBUG = true

function M.dbg(msg)
    if not (FLAG_DEBUG)
    then
      return
    end
    print("[debug]: " .. msg)
end

function M.log(msg)
  print("[log]: " .. msg)
end

return M

