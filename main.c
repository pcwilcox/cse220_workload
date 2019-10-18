#include "cJSON.h"
#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>

int
main(int argc, char** argv)
{
    int i;

    /* run a loop to increase instruction count */
    for (i = 0; i < 100; i++) {
        printf("Starting run %d\n", i);
        /* Open the input file */
        FILE *f = fopen(argv[1], "rb");
        fseek(f, 0, SEEK_END);
        long fsize = ftell(f);
        fseek(f, 0, SEEK_SET);

        /* read it to a string */
        char *string = (char*)malloc(fsize + 1);
        fread(string, 1, fsize, f);
        fclose(f);

        /* Parse the input */
        cJSON *json = cJSON_Parse(string);
        cJSON_Delete(json);
    }
    printf("All done!\n");
    return 0;
}
