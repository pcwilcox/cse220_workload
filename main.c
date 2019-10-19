/* The code here is heavily adapted from example4 of the genann repo:
 *   https://github.com/codeplea/genann
 */

#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>
#include <math.h>
#include "genann.h"

const char *training_data = "/home/cse220/cse220_workload/data/wdbc.data";
const char *test_data = "/home/cse220/cse220_workload/data/wpbc.data";
const int num_features = 10;

enum {
    RADIUS,
    TEXTURE,
    PERIMETER,
    AREA,
    SMOOTHNESS,
    COMPACTNESS,
    CONCAVITY,
    CONCAVE_POINTS,
    SYMMETRY,
    FRACTAL_DIMENSION
} features;

typedef double sample[10];

double *malignant;
sample *samples;

int num_samples;

void
load_data()
{
    FILE *in = fopen(training_data, "r");
    if (!in) {
        fprintf(stderr, "Could not open file: %s\n", training_data);
        exit(1);
    }

    char line[1024];
    while (!feof(in) && fgets(line, 1024, in)) {
        ++num_samples;
    }
    fseek(in, 0, SEEK_SET);

    printf("Loading %d data points from %s\n", num_samples, training_data);

    samples = (sample *)malloc(sizeof(sample) * num_samples);
    malignant = (double *)malloc(sizeof(double) * num_samples);
    for (int i = 0; i < num_samples; i++) {
        if (fgets(line, 1024, in) == NULL) {
            perror("fgets");
            exit(1);
        }

        char *split = strtok(line, ",");
        split = strtok(NULL, ",");
        if (!strcmp(split, "M")) {
            malignant[i] = 1.0;
        } else {
            malignant[i] = 0.0;
        }
        for (int j = 0; j < num_features; j++) {
            split = strtok(NULL, ",");
            samples[i][j] = atof(split);
        }
    }
    fclose(in);
}

int
main(int argc, char **argv)
{
    if (argc < 3) {
        fprintf(stderr, "usage: ./genann <num_iterations> <learning_rate>\n");
        exit(1);
    }

    int loops = atoi(argv[1]);
    float alpha = atof(argv[2]);

    printf("GENANN Breast Cancer Training\n");
    srand(time(0));

    load_data();

    genann *ann = genann_init(10, 5, 15, 2);

    /* training */
    for (int i = 0; i < loops; i++) {
        for (int j = 0; j < num_samples; j++) {
            genann_train(ann, samples[j], &malignant[j], alpha);
        }
    }

    int correct = 0;
    for (int j = 0; j < num_samples; j++) {
        const double *guess = genann_run(ann, samples[j]);
        if (malignant[j] == 1.0) {
            if (guess[0] > guess[1]) {
                correct++;
            }
        } else if (malignant[j] == 0.0) {
            if (guess[1] > guess[0]) {
                correct++;
            }
        }
    }
    printf("%d/%d correct (%0.1f%%).\n", correct, num_samples, (double)correct / num_samples * 100.0);

    genann_free(ann);
    free(samples);
    free(malignant);
    return 0;
}
