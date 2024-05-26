using System;

class Program
{
    static void Main()
    {
        //instancia de la clase NumerosHandler
        NumerosHandler handler = new NumerosHandler(100);
        handler.ProcesarNumeros();
    }
}

class NumerosHandler
{
    private int[] numeros;

    // Constructor inicializa la lista de números
    public NumerosHandler(int cantidad)
    {
        numeros = new int[cantidad];
        for (int i = 0; i < cantidad; i++)
        {
            numeros[i] = i + 1;
        }
    }

    // Método que procesa y muestra los resultados
    public void ProcesarNumeros()
    {
        foreach (int numero in numeros)
        {
            Console.WriteLine(ObtenerResultado(numero));
        }
    }

    // Método que determina el resultado para cada número
    private string ObtenerResultado(int numero)
    {
        if (numero % 3 == 0 && numero % 5 == 0)
            return $"{numero} = Bingo!";
        else if (numero % 3 == 0)
            return $"{numero} = Bin!";
        else if (numero % 5 == 0)
            return $"{numero} = Go!";
        else
            return $"{numero} = No es divisible por 3 ni 5";
    }
}
