def extraerObjetos(lineas):
	l_aux = lineas
	num_objetos = int(l_aux[0].split()[2])
	lineas_objetos = l_aux[1:num_objetos+1]
	del(l_aux[:num_objetos+1])

	return lineas_objetos
#########################################################
#########################################################
def extraerPesoMochilas(lineas):
	laux = lineas


	d = {}

	for i in laux:
		aux = i.split()
		peso_mochila = " ".join(aux[-2:])
		id_mochila = " ".join(aux[2:-3])
		if d.has_key(id_mochila)!=True:
			d[id_mochila]=peso_mochila

	return d
#########################################################
#########################################################
def procesaObejetos(lineas):
	def extraer(linea):
		aux = linea.split()
		#item aux[:-6],peso aux[-5:-3],precio aux[-2:]
		#b = tupla(Objeto,Peso,Precio)
		b = (" ".join(aux[:-6])," ".join(aux[-5:-3])," ".join(aux[-2:]))

		return b
	d = {}
	for linea in lineas:
		aux = extraer(linea)
		obj,pes,pre = aux[0],aux[1],aux[2]
		if d.has_key(obj)!=True:
			d[obj]=(pes,pre)

	return d
#########################################################
#########################################################

#lista con el texto a analizar
lineas = open("multiplesMochilas.txt").readlines()

items_mochila = procesaObejetos(extraerObjetos(lineas))
pesos_mochila = extraerPesoMochilas(lineas)

for k,v in items_mochila.items():
	print "Item --> "+k+" :",v

print "\n"

for k,v in pesos_mochila.items():
	print k+" :" ,v
