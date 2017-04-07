(
var harmonies, rhythm;
var tableSelect, melody;
var master, lh, rh;

harmonies = Array2D.fromArray(3,3,
	[
		'',           'section 1',         'section 2',
		'harmony 1',  [-2, 2, 6, 11, 19],  [0, 4, 10, 15, 23],
		'harmony 2',  [-1, 2, 7, 12b, 18], [1, 4, 9b, 16b, 23b],
	]
);

rhythm = [6, 6, 4, 4, 4, 3, 3, 3, 3, 2, 2, 2, 2, 2, 1, 1, 3, 3, 3, 3] * 16.reciprocal * 4;

tableSelect = {
	arg table, row, column;

	table[table.colAt(0).indexOf(row), table.rowAt(0).indexOf(column)];
};

melody = {
	arg melody, section;
	[1, 1, 2, 2].collect{
		arg harmony;
		melody.collect{
			arg i;
			tableSelect.(harmonies, ('harmony ' ++ harmony).asSymbol, section)[i];
		};
	}.flat;
};

master = Pbind(
	\type, \midi,
	\midiout, m,
	\legato, 100,
	\octave, 4,
);

lh = Pbindf(
	master,
	\degree, Pseq(
		[
			Pser(melody.([0, 1, 2, 1], 'section 1'), 80),
			Pser(melody.([0, 1, 2, 1], 'section 2'), 80),
		], 2
	),
	\dur, Pseq(rhythm, 16, offset: 0),
);

rh = Pbindf(
	master,
	\degree, Pseq(
		[
			Pser(melody.([3, 4], 'section 1'), 80),
			Pser(melody.([3, 4], 'section 2'), 80),
		], 2
	),
	\dur, Pseq(rhythm, 16, offset: 2),
);

TempoClock.tempo = 60/60;

Pbindf(
	Ppar([lh, rh]),
	\type, Pseq([
		Pser([\midi,\rest,\rest,\rest,\rest,\rest,\rest,\rest], 40 * 2),
		Pser([\midi,\rest,\rest,\rest], 40),
		Pser([\midi,\rest], 40),
		Pser([\midi], 40 * 8),
		Pser([\midi,\rest], 40),
		Pser([\midi,\rest,\rest,\rest], 40),
		Pser([\midi,\rest,\rest,\rest,\rest,\rest,\rest,\rest], 40 * 2)
	]);
).play;
)