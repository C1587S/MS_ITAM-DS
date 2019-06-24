'''
Modulo para calcular la aproxiamación de las primeras y segundas derivadas con diferencias hacia adelante con el teorema de Taylor.
'''
def aprox_derivada_centradas(f,x,h):
    df = (f(x+h)-f(x-h))/(2*h)
    return df

def aprox_2a_derivada_centradas(f,x,h):
    ddf = (f(x+h)-2*f(x)+f(x-h))/(h**2)
    return ddf