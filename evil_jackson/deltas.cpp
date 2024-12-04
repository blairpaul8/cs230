#include <cmath>
#include <cstddef>
#include <cstdint>
#include <iostream>

struct Observation {
  char point_1;
  short point2;
  long point3;
  int point4;
  long point5;
};

extern "C" {
int CalculateAllDeltas(Observation *observations, size_t observations_len,
                       int *highest_observation);
}

int CalculateAllDeltas(Observation *observations, size_t observations_len,
                       int *highest_observation) {
  int highest = INT32_MIN;
  int total = 0;

  for (size_t i = 0; i < observations_len; i++) {
    float delta = sqrt(observations[i].point5 - observations[i].point_1);

    int final_observation = int(floor(delta));

    if (final_observation > highest) {
      highest = final_observation;
    }

    total += delta;
  }

  *highest_observation = highest;
  return total;
}
