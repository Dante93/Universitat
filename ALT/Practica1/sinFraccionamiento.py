def show_fractional_knapsack(x, v, w):
  print '\nValor total: %s.' % sum(x[i]*v[i] for i in xrange(len(x))),
  print 'Carga total: %s.'   % sum(x[i]*w[i] for i in xrange(len(x)))
  print 'Detalle de la carga: %s.' \
            % ''.join('\n - %6.2f%% de %s' % (100*x[i], i) \
                        for i in xrange(len(x)) if x[i] > 0)

def mochila_sin_fraccionamiento(w, v, W):
	x = [0] * len(w)


	v = sorted([(v[i]/float(w[i]), i,v[i]) for i in xrange(len(w))],
                         reverse=True)
	#V contiene (peso_unitario,item,peso)
	#Si hay algun objeto que pese mas de W lo quitamos
	for (ratio,i,value) in v:
		if w[i]>W:
			del v[i]

	benefici = 0
 	i = 0
	while W > 0 and i < len(v):
		aux = v[i] #aux(precioU,item,valor)
		pesoObj = w[aux[1]]

		if pesoObj<=W:
			W -= pesoObj
			benefici += aux[2]
			x[aux[1]] +=1
		i+=1
	return benefici



W = 50
v=[60,20,40,20,75]
w=[40,30,20,10,60]#Valor_obejecte,Pes_objecte
q=mochila_sin_fraccionamiento(w, v, W)
print "El beneficio es de: ",q
