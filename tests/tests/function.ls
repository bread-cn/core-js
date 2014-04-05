isFunction = -> typeof! it  is \Function
test 'Function.isFunction' !->
  {isFunction} = Function
  ok typeof isFunction is \function, 'Is function'
  ok isFunction(->), 'isFunction function'
  for [void, null, 1, '', no, {}, do -> &, [], /./]
    ok not isFunction(..), "not isFunction #{typeof! ..}"
test 'Function.isNative' !->
  {isNative} = Function
  ok isFunction(isNative), 'Is function'
  ok isNative(Object::hasOwnProperty), 'isNative native function'
  for [->, void, null, 1, '', no, {}, do -> &, [], /./]
    ok not isNative(..), "not isNative #{typeof! ..}"
test 'Function::methodize' !->
  ok isFunction(Function::methodize), 'Is function'
  ok {a: 42, fn: (-> it.a)methodize!}fn! is 42
  num = new Number 42
  num.fn = ((a, b)-> a + b)methodize!
  ok num.fn(21) is 63
test 'Function::part' !->
  ok isFunction(Function::part), 'Is function'
  ok (-> typeof! it is \String)part(\qwe)!
  obj = a: 42
  obj.fn = (-> @a + it)part 21
  ok obj.fn! is 63
  $ = Function._
  fn = -> Array::map.call(&, String).join ' '
  part = fn.part $, \Саша, $, \шоссе, $, \сосала
  ok isFunction(part), '.part with placeholders return function'
  ok part(\Шла \по) is 'Шла Саша по шоссе undefined сосала', '.part with placeholders: args < placeholders'
  ok part(\Шла \по \и) is 'Шла Саша по шоссе и сосала', '.part with placeholders: args == placeholders'
  ok part(\Шла \по \и \сушку) is 'Шла Саша по шоссе и сосала сушку', '.part with placeholders: args > placeholders'
test 'Function::construct' !->
  ok isFunction(Function::construct), 'Is function'
  class C
    (@a, @b)->
  ok C.construct([]) instanceof C
  deepEqual C.construct([1 2]), new C 1 2