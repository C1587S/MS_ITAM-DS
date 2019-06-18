
# para importar el módulo que creamos
import dif_centrada
import math
# Función de prueba: math.asin y x=0.5.
ftest = math.asin
xtest = 0.5
print('-'*10)
df = dif_centrada.aprox_derivada(xtest, ftest)
print('-'*10)
dff = dif_centrada.aprox_2a_derivada(xtest, ftest)
print('-'*10)
