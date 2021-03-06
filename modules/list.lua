-- Module to provide the needed linked list functionality

list = {}

local function iterate(list, current)
  if current then
    current = current.next
  else
    current = list.first
  end
  
  return current
end

function list.add(t, obj)
  if t.first then
    t.last.next = obj
    obj.prev = t.last
  else
    t.first = obj
  end
  
  t.last = obj
  t.count = t.count + 1
  return obj
end

function list.unshift(t, obj)
  if t.first then
    t.first.prev = obj
    obj.next = t.first
  end
  
  t.first = obj
  t.count = t.count + 1
  return obj
end

function list.remove(t, obj)
  if obj.next then
    if obj.prev then
      obj.next.prev = obj.prev
      obj.prev.next = obj.next
    else
      obj.next.prev = nil
      t.first = obj.next
    end
  elseif obj.prev then
    obj.prev.next = nil
    t.last = obj.prev
  else
    t.first = nil
    t.last = nil
  end
  
  obj.next = nil
  obj.prev = nil
  t.count = t.count - 1
end

function list.clear(t)
  local v = t.first
  
  while v do
    local next = v.next
    list.remove(t, v)
    v = next
  end
end

function list.each(t)
  return iterate, t, nil
end
