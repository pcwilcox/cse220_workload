#include <stdio.h>
#include <string.h>
#include "trie.h"

#define LINESIZE 1024

int
main(int argc, char **argv)
{
    int i;
    char line[LINESIZE + 1] = {0};
    char *str;
    FILE *f;
    Trie *trie = trie_new();

    for (i = 1; i < argc; i++) {
        printf("Reading %s\n", argv[i]);
        f = fopen(argv[i], "r");

        while (1) {
            if (fgets(line, LINESIZE, f) == NULL)
                break;
            str = strtok(line, " ");
            while (1) {
                trie_insert(trie, str, str);
                if ((str = strtok(NULL, " ")) == NULL)
                    break;
            }
        }
        fclose(f);
    }
    trie_free(trie);
    printf("All done\n");
    return 0;
}

