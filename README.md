# Arvelie date utility in Scheme

A just for fun implementation of the [C Arvelie date utility](https://github.com/XXIIVV/oscean/tree/master/src/projects/arvelie) in Scheme.

Implemented utilities:

- `convert-arvelie`: converts from/to gregorian/arvelie
- `valid-date`: validates a date in gregorian/arvelie
- `valid-arvelie`: validates a date in arvelie format
- `valid-gregorian`: validates a date in gregorian
- `gregorian-to-arvelie`: converts from gregorian to arvelie
- `arvelie-to-gregorian`: converts from arvelie to gregorian

Example of usage:

```
$ mit-scheme
Copyright (C) 2019 Massachusetts Institute of Technology
This is free software; see the source for copying conditions. There is NO warranty; not even for
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

Image saved on Saturday August 10, 2019 at 7:30:42 PM
  Release 10.1.10 || Microcode 15.3 || Runtime 15.7 || SF 4.41 || CREF 2.6 || LIAR/svm1 4.118

1 ]=> (load "arvelie.scm")

;Loading "arvelie.scm"...
;  Loading "support.scm"... done
;... done
;Value: convert-arvelie

1 ]=> (convert-arvelie "20O08")

;Value: "2020-07-22"
```

You can run the tests with `mit-scheme --quiet < tests.scm`.

[More information on Arvelie calendar](https://wiki.xxiivv.com/site/arvelie.html)