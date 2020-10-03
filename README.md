# Arvelie date utility in Scheme

A just for fun implementation of the [C Arvelie date utility](https://github.com/XXIIVV/oscean/tree/master/src/projects/arvelie) in Scheme.

Utilities implemented:

- `convert-arvelie`: converts from/to gregorian/arvelie
- `valid-date`: validates a date in gregorian/arvelie
- `valid-arvelie`: validates a date in arvelie format
- `valid-gregorian`: validates a date in gregorian
- `gregorian-to-arvelie`: converts from gregorian to arvelie
- `arvelie-to-gregorian`: converts from arvelie to gregorian

You can run the tests with `mit-scheme --quiet < tests.scm`.

[More information on Arvelie calendar](https://wiki.xxiivv.com/site/arvelie.html)