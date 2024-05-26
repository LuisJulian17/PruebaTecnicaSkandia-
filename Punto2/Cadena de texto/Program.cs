using System;

class Program
{
    static void Main()
    {
        Console.WriteLine("Ingrese una cadena de texto");
        string texto = Console.ReadLine();

        while (string.IsNullOrEmpty(texto))
        {
            Console.WriteLine("Debe ingresar una cadena valida. Intentelo de nuevo: ");
            texto = Console.ReadLine();
        }

        string[] palabras = texto.Split(' ');

        Array.Reverse(palabras);

        string resultado = string.Join(" ", palabras);

        Console.WriteLine();
        Console.WriteLine("Cadena original:");
        Console.WriteLine(texto);
        Console.WriteLine();
        Console.WriteLine("Cadena con palabras en orden inverso:");
        Console.WriteLine(resultado);
    }
}