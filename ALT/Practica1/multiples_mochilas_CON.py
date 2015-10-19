def show_fractional_knapsack(x, v, w):
	print '\nValor total: %s.' % sum(x[i]*v[i] for i in xrange(len(x))),
	print 'Carga total: %s.'   % sum(x[i]*w[i] for i in xrange(len(x)))
	print 'Detalle de la carga: %s.' \
            % ''.join('\n - %6.2f%% de %s' % (100*x[i], i) \
                        for i in xrange(len(x)) if x[i] > 0)

def fractional_knapsack(w, v, W):
	x = [0] * len(w)
	v = sorted([(v[i]/float(w[i]), i) for i in xrange(len(w))],
                         reverse=True)

	for peso in xrange(len(W)):
		aux = W[peso]
		for (ratio, i) in v:
			x[i] = min(1, aux/float(w[i]))
			aux -= x[i] * w[i]
		return x

#Lee los datos del fichero y devuleve una tupla con 3 listas
def read_data(txt):

	kg_to_gr = 1000.0
	dollar_to_Euro = 0.74
	libras_to_Euro =1.19

	f = open(txt,'r')
	lineas = f.readlines()


	w=[]
	v=[]

	for l in lineas[1:-3]:
		# pesa X kg vale Y euros
		l = l.lower().split(' ')[-6:]
		#Sacamos el peso y precio
		peso,precio = float(l[1]), float(l[4])
		#pasamos a gr
		if 'kg' in l:
			peso = peso * kg_to_gr
		else:
			peso
		if not 'euros' in l:
			precio = precio*dollar_to_Euro if 'dolares' in l else precio * libras_to_Euro

		w.append(peso)
		v.append(precio)


	#W es el vector de capacidades de las mochilas
	W=[]
	num_objetos = lineas[0].split()
	num_objetos = int(num_objetos[2])
	for i in lineas[num_objetos+1:]:
		line = i.split()
		peso = float(line[-2])

		if 'kg' in line:
			peso = peso*kg_to_gr
		else:
			peso


		W.append(peso)

	return W,w,v


#MAIN#
a = read_data('multiplesMochilas.txt')
W,w,v = a[0],a[1],a[2]
q=fractional_knapsack(w, v, W)
show_fractional_knapsack(q, v, w)
