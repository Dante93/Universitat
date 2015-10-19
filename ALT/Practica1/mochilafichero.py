def show_fractional_knapsack(x, v, w):
  print '\nValor total: %s.' % sum(x[i]*v[i] for i in xrange(len(x))),
  print 'Carga total: %s.'   % sum(x[i]*w[i] for i in xrange(len(x)))
  print 'Detalle de la carga: %s.' \
            % ''.join('\n - %6.2f%% de %s' % (100*x[i], i) \
                        for i in xrange(len(x)) if x[i] > 0)

def fractional_knapsack(w, v, W):
  x = [0] * len(w)
  print x
  v = sorted([(v[i]/float(w[i]), i) for i in xrange(len(w))],
                         reverse=True)
  print v
  for (ratio, i) in v:
    x[i] = min(1, W/float(w[i]))
    W -= x[i] * w[i]
  return x

W = 50
v,w = [60,20,40,20,75],[40,30,20,10,50]#Valor_obejecte,Pes_objecte
q=fractional_knapsack(w, v, W)
show_fractional_knapsack(q, v, w)
