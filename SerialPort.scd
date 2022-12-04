// Aqui está funcionando... Agora descobrir como trabalhar com os dados
// Fazer um teste usando aquele tutorial no youtube
SerialPort.devices;
~port = SerialPort("/dev/cu.usbserial-1420", 9600);

~port.read


(
SynthDef(\clavier, {
	| freq = 240, decay= 0.1 |
	Out.ar([0, 1], Saw.ar(freq+200, EnvGen.ar(Env([1, 0], [decay]), doneAction: 2)))
}).add
)
a = Synth(\clavier, [\freq, ~port.read])
a.free

// Como extrair um ~port.read só de cada vez, e usar em todos os synths?
(
t = Task({
	inf.do({
		rrand(3, 40).do({
			Synth(\clavier, [\freq, ~port.read + rrand(50, 300) * rrand(1.0, 2.0), \decay, rrand(0.1, 2.0)]);
			0.1.wait;
		});
		rrand(2, 10).do({
			Synth(\clavier, [\freq, ~port.read + rrand(25, 300) * rrand(1.0, 2.4), \decay, rrand(0.3, 4.0)]);
			0.7.wait;
		});
	})
})
)
t.start;
t.stop;

(
v = Task({
	inf.do({
		x = ~port.read;
		Synth(\clavier, [\freq, x + 50, \decay, 1.5]);
		0.25.wait;
		Synth(\clavier, [\freq, x + 50 * 2.05, \decay, 1.25]);
		0.25.wait;
		Synth(\clavier, [\freq, x + 50 * 2.9, \decay, 1]);
		0.25.wait;
		Synth(\clavier, [\freq, x + 50 * 4.2, \decay, 0.75]);
		0.25.wait;
		})
})
)
v.start;
v.stop;
x

(
u = Task({
	inf.do({ postln(~port.read) });
	0.3.wait;
})
)
u.start
u.stop

~port.close;

(
SynthDef(\sin, { | freq = 440 |
	Out.ar(0, SinOsc.ar(freq+200))
}).add;
)

m = Synth(\sin)

(
f = Task({
	inf.do({
		m.set(\freq, ~port.read);
		0.10.wait;
	})
})
)
f.start
f.stop

~port.read

~port = SerialPort("/dev/cu.usbserial-1420", 9600);

~port.close;

// Por algum motivo não rolou... ArduinoSMS aparentemente funciona, só não ficou claro ainda quais são as diferenças entre cada um e para que servem...
p = ArduinoSMS("/dev/tty.usbserial-1420", 9600)
p.action = { | ... msg | msg.postln }
p.send($r, $a)
p.close
p

ArduinoParser
ArduinoParserSMS