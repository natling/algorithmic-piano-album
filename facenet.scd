(
var voices = Array2D.fromArray(5, 3,
	[
		'voice', 'notes',                                            'rhythm',
		'1',      Pstep(Pseq([8b, 8, 9, 9s]),        7 * 5 / 2, inf), Pseq([5] * 8.reciprocal * 4, 10 * 7 + 1),
		'2',      4,                                                  Pseq([5] * 8.reciprocal * 4, 10 * 7 + 1),
		'3',      Pstep(Pseq([2, 2s, 3], offset: 2), 7 * 5 / 2, inf), Pseq([7] * 8.reciprocal * 4, 10 * 5 + 1),
		'4',      0,                                                  Pseq([7] * 8.reciprocal * 4, 10 * 5 + 1),
	]
);

TempoClock.tempo = 60/60;

Array.fill(4,
	{
		arg i;

		Pbind(
			\type, \midi,
			\midiout, m,
			\legato, 10,
			\scale, Scale.minor,
			\root, -3,
			\octave, Pseq([5, 6], inf),
			\degree, voices[i + 1, voices.rowAt(0).indexOf('notes')],
			\dur,    voices[i + 1, voices.rowAt(0).indexOf('rhythm')],
		).play;
	};
);
)