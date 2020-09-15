#include <math.h>
#include <string.h>
#include <time.h>

int is_valid_arvelie(char *date) {
  int y = ((date[0] - '0') * 10) + date[1] - '0';
  int m = date[2] - 'A';
  int d = ((date[3] - '0') * 10) + date[4] - '0';
  if (strlen(date) != 5) {
    return 0;
  }
  if (y < 0 || y > 99 || m < 0 || m > 26 || d < 0 || d > 14) {
    return 0;
  }
  return 1;
}

int is_valid_ymdstr(char *date) {
  int y = (date[0] - '0') * 1000 + (date[1] - '0') * 100 +
    (date[2] - '0') * 10 + date[3] - '0';
  int m = (date[5] - '0') * 10 + date[6] - '0';
  int d = (date[8] - '0') * 10 + date[9] - '0';
  if (strlen(date) != 10) {
    return 0;
  }
  if (y < 0 || y > 9999 || m < 0 || m > 12 || d < 0 || d > 31) {
    return 0;
  }
  return 1;
}

int ymd_to_doty(int y, int m, int d) {
  int i = 0, daymon = 0, dayday = 0;
  int months[13] = {0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
  if ((y % 4) || ((y % 100) && (y % 400))) {
    months[3] = months[3] + 1;
  }
  for (i = 0; i < m; i++) {
    daymon += months[i];
  }
  dayday = d;
  return (daymon + dayday) - 1;
}

int arvelie_to_doty(char *date) {
  int m = date[2] - 'A';
  int d = ((date[3] - '0') * 10) + date[4] - '0';
  int doty = (m * 14) + d;
  return doty == -307 ? 364 : doty;
}

int arvelie_to_epoch(char *date){
  int y = ((date[0] - '0') * 10) + date[1] - '0';
  return arvelie_to_doty(date) + (y*365);
}

int get_epoch(){
  int y,m,d;
  time_t now;
  struct tm *local;
  time(&now);
  local = localtime(&now);
  y = local->tm_year + 1900;
  m = local->tm_mon + 1;
  d = local->tm_mday;
  return (y%100) * 365 + ymd_to_doty(y, m, d);
}

/* TODO: Cleanup */

int extract_year(char *arvelie) {
  int result = 0, i = 0;
  for (i = 0; i < 2; i++) {
    result = result * 10 + (arvelie[i] - '0');
  }
  return result;
}

int doty_to_month(int doty) {
  int month = 0;
  int months[13] = {0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334, 365};
  while (months[month] < doty) {
    month++;
  }
  return month - 1;
}

int doty_to_day(int doty) {
  int month = 0;
  int months[13] = {0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334, 365};
  while (months[month] < doty) {
    month++;
  }
  return doty - months[month - 1];
}

/* Prints */

void print_ymdstr_from_doty(int y, int doty) {
  int d, m = 0, months[13] = {0,   31,  59,  90,  120, 151, 181,
    212, 243, 273, 304, 334, 365};
  while (months[m] < doty) {
    m++;
  }
  if (m < 1) {
    printf("Error: Unknown Month\n");
    exit(0);
  }
  d = doty - months[m - 1];
  printf("%04d-%02d-%02d\n", y, m, d);
}

void print_arvelie_from_doty(int y, int doty) {
  char *months[] = {"A", "B", "C", "D", "E", "F", "G", "H", "I",
    "J", "K", "L", "M", "N", "O", "P", "Q", "R",
    "S", "T", "U", "V", "W", "X", "Y", "Z", "+"};
  int d = (doty % 14) + 1;
  char *m = months[doty / 14];
  printf("%d%s%02d\n", y % 100, m, d);
}

void print_arvelie_from_time(time_t t) {
  struct tm *local = localtime(&t);
  int y = local->tm_year + 1900;
  int m = local->tm_mon + 1;
  int d = local->tm_mday;
  print_arvelie_from_doty(y, ymd_to_doty(y, m, d));
}

void print_arvelie_from_ymdstr(char *date) {
  int y = (date[0] - '0') * 1000 + (date[1] - '0') * 100 +
    (date[2] - '0') * 10 + date[3] - '0';
  int m = (date[5] - '0') * 10 + date[6] - '0';
  int d = (date[8] - '0') * 10 + date[9] - '0';
  if (!is_valid_ymdstr(date)) {
    printf("Error: Invalid YYYY-MM-DD date\n");
    exit(0);
  }
  print_arvelie_from_doty(y, ymd_to_doty(y, m, d));
}

void print_ymdstr_from_arvelie(char *date) {
  int y = ((date[0] - '0') * 10 + date[1] - '0') + 2000;
  if (!is_valid_arvelie(date)) {
    printf("Error: Invalid arvelie date\n");
    exit(0);
  }
  print_ymdstr_from_doty(y, arvelie_to_doty(date));
}

void print_arvelie() {
  time_t now;
  time(&now);
  print_arvelie_from_time(now);
}
