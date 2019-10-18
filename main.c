#include "cJSON.h"
#include <stdio.h>

int
main(int argc, char** argv)
{
    /* Parse the input */
    cJSON *json = cJSON_Parse(argv[1]);
    cJSON_Delete(json);
    printf("All done!\n");
    return 0;
}
