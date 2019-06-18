# Modoludo de primeras y segundas diferencias centradas

# Función para la aproximación centrada de la primera derivada
# x: punto donde se aproxima
# fun: función a evaluar
# h: magnitud de diferencia entre puntos


def aprox_derivada(x, fun, h=1e-6):
    df = (fun(x+h) - fun(x-h))/2.0*h
    print(f"Función siendo evaluada: {fun}")
    print(f"La primera derivada centrada en x = {x} es: {df}.")
    return df

# Función para la aproximación centrada de la segunda derivada
# Se repiten los argumentos de aprox_derivada.


def aprox_2a_derivada(x, fun, h=1e-6):
    dff = (fun(x+h) - 2*fun(x) + fun(x-h))/h**2
    print(f"Función siendo evaluada: {fun}")
    print(f"Las segunda derivada centrada en x = {x} es: {dff}.")
    return dff
