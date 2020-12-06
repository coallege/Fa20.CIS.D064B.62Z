#include <stddef.h>
#include <stdio.h>
#include <time.h>
#include <stdlib.h>
#include <windows.h>
#include <iostream>
#include <string>

int main() {
   puts(
      "Extracting the midterm will take some time.\n"
      "Please wait..."
   );

   srand((unsigned) time(NULL));
   char timeleft = 0;
   while (timeleft < 100) {
      auto r = rand();
      Sleep(r / 3);
      printf("%d%% complete...\n", timeleft);
      if (r < 0xeee) {
         timeleft--;
      } else {
         timeleft++;
      }

      if (r < RAND_MAX / 3) {
         char i{}; // fun fact, if you don't initialize that, it's always 'y'
         while (i != 'y') {
            printf("Minor error 0x%x. Recoverable. Continue? [y/n]\n> ", r * rand());
            std::string temp;
            getline(std::cin, temp);
            i = {temp.c_str()[0]};
         }
      }
   }

   // you fool. you absolute buffoon.
   // you think I would actually include my midterm in a *public* repository?
   puts("Critical error, try again.");
   system("pause");
}
