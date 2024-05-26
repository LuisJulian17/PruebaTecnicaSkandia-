using System;

class Program
{
    static void Main()
    {
        // Crear una instancia TextProcessor
        TextProcessor processor = new TextProcessor();
        processor.ProcesarTexto();
    }
}

class TextProcessor
{
    private string texto;

    // Método que gestiona el proceso completo de entrada, inversión y salida
    public void ProcesarTexto()
    {
        SolicitarTexto();
        string resultado = InvertirPalabras(texto);
        MostrarResultados(texto, resultado);
    }

    // Método para solicitar la entrada del texto
    private void SolicitarTexto()
    {
        Console.WriteLine("Ingrese una cadena de texto");
        texto = Console.ReadLine();

        while (string.IsNullOrEmpty(texto))
        {
            Console.WriteLine("Debe ingresar una cadena válida. Inténtelo de nuevo: ");
            texto = Console.ReadLine();
        }
    }

    // Método para invertir las palabras en la cadena
    private string InvertirPalabras(string input)
    {
        string[] palabras = input.Split(' ');
        Array.Reverse(palabras);
        return string.Join(" ", palabras);
    }

    // Método para mostrar los resultados
    private void MostrarResultados(string original, string invertido)
    {
        Console.WriteLine();
        Console.WriteLine("Cadena original:");
        Console.WriteLine(original);
        Console.WriteLine();
        Console.WriteLine("Cadena con palabras en orden inverso:");
        Console.WriteLine(invertido);
    }
}
