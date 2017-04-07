(
var notes, form;

notes = Array2D.fromArray(3, 5,
	[
		-18,  2,  -2,  -11,  [0,  4],
		-18s, 1s, -2s, -11s, [0s, 3],
		-17,  3,  -1,  -10,  [0s, 4],
	]
);

form = Array2D.fromArray(11, 6,
	[
		0, 0, 0, 0, 0,    1,
		0, 0, 0, 0, 1,    1,
		0, 0, 0, 1, 1,    1,
		0, 0, 1, 1, 1,    1,
		0, 1, 1, 1, 1,    1,
		1, 1, 1, 1, 1,    1,
		1, 1, 1, 1, 2,    1,
		1, 1, 1, 2, 2,    1,
		1, 1, 2, 2, 2,    1,
		1, 2, 2, 2, 2,    1,
		2, 2, 2, 2, 2,    2,
	]
);

TempoClock.tempo = 76 * 3 / 60;

Pbind(
	\type, \midi,
	\midiout, m,
	\legato, inf,
	\dur, 8.reciprocal * 4,
	\amp, Pseq([1, 0.9, 0.9, 0.9, 0.9, 0.9], inf),
	\degree, Pseq(
		11.collect{
			arg section;
			Pseq(
				[
					5.collect{
						arg note;
						notes[form[section, note], note]
					}
				].flatten(1),
				6 * form[section, 5]
			)
	})
).play;
)