using System;

class Program
{
    static void Main()
    {
        int n = 2;
        int total = 1;

        while(total <= 50){

            bool esPrimo = true;

            for (int i = 2; i < n; i++) {
                if(n % i == 0)
                {
                    esPrimo = false;
                    break;
                }
            }
            if(esPrimo)
            {
             Console.WriteLine(n);
              total++;
            }
            n++;
        }
    }
}
