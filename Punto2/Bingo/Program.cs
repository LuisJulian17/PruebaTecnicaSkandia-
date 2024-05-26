using System;

class Program
{
    static void Main()
    {
        int[] numeros = new int[100];

        for (int i = 0; i < 100; i++)
        {
            numeros[i] = i + 1;
        }
        // Codigo para calcular los numeros con foreach
        foreach (int numero in numeros)
        {
            string resultado =
                (numero % 3 == 0 && numero % 5 == 0) ? $"{numero} = Bingo!" :
                (numero % 3 == 0) ? $"{numero} = Bin!" :
                (numero % 5 == 0) ? $"{numero} = Go!" :
                $"{numero} = No es divisible por 3 ni 5";
            Console.WriteLine(resultado);
        }

        // Codigo para calcular los numeros con For
        
        /*for (int i = 0; i < 100; i++)
        {
            int numero = numeros[i];
            if (numero % 3 == 0 && numero % 5 == 0)
            {
                Console.WriteLine($"{numero} = Bingo!");
            }
            else if (numero % 3 == 0)
            {
                Console.WriteLine($"{numero} = Bin!");
            }
            else if (numero % 5 == 0)
            {
                Console.WriteLine($"{numero} = Go!");
            }
            else
            {
                Console.WriteLine($"{numero} = No es divisible por 3 ni 5");
            }
        }*/
    }

}
