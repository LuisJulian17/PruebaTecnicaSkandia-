using System;

class Program
{
    static void Main()
    {
        // Crear una instancia de PrimeNumberGenerator
        PrimeNumberGenerator generator = new PrimeNumberGenerator();
        generator.GeneratePrimes(50);
    }
}

class PrimeNumberGenerator
{
    // Método para generar y mostrar números primos
    public void GeneratePrimes(int limit)
    {
        int n = 2;
        int total = 1;

        while (total <= limit)
        {
            if (IsPrime(n))
            {
                Console.WriteLine(n);
                total++;
            }
            n++;
        }
    }

    // Método para verificar si un número es primo
    private bool IsPrime(int number)
    {
        if (number < 2) return false;

        for (int i = 2; i <= Math.Sqrt(number); i++)
        {
            if (number % i == 0)
                return false;
        }
        return true;
    }
}
