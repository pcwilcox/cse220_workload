#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "edlib.h"

static const char *target_file = "/home/cse220/cse220_workload/reference.txt";

int
main(int argc, char** argv)
{
    int i, len_query, len_target, num_queries;
    char *query, *target, c;
    FILE *f;

    /* verify input */
    num_queries = argc - 1;
    if (num_queries < 1) {
        fprintf(stderr, "Usage: workload <target_1> [target_2] [...] [target_n]\n");
        exit(1);
    }

    /* load reference data */
    f = fopen(target_file, "r");
    while (!feof(f) && fgets(&c, 1, f)) ++len_target;
    fseek(f, 0, SEEK_SET);

    target = (char *)malloc(len_target + 1);
    memset(target, 0, len_target + 1);
    if (fgets(target, len_target, f) == NULL) {
        perror("fgets");
        exit(1);
    }

    fclose(f);

    /* default config for now */
    EdlibAlignConfig config = edlibDefaultAlignConfig();

    /* cycle through each input arg and run the aligner */
    for (i = 0; i < num_queries; ++i) {
        query = argv[i + 1];
        len_query = strlen(query);
        EdlibAlignResult result = edlibAlign(query, len_query, target, len_target, config);
        printf("Edit Distance: %d - NumLocations: %d\n", result.editDistance, result.numLocations);
        edlibFreeAlignResult(result);
    }
    return 0;
}


