SerialPort.devices
~port = SerialPort("dev/cu.usbserial-1420", 9600);
~port.close;

(
x = [ ];
30.do{x = x.add(~port.read)};
)
x.collect(_.asAscii);

//Read and convert the values from arduino
(
~charArray = [ ];
r = Routine({
	| ascii |
	{
		ascii = ~port.read.asAscii;
		if(ascii.isDecDigit, {~charArray = ~charArray.add(ascii)});
		if(ascii == $a, {
			//convert characters in array to integers and then empty the array
			~val = ~charArray.collect(_.digit).convertDigits;
			~charArray = [ ];
		});
	}.loop;
}).play;
)
~val;
r.stop

(
SynthDef(\photosaw, {
	arg cutoff = 1000;
	var sig;
	sig = Saw.ar([50, 51]);
	sig = RLPF.ar(sig, cutoff.lag(0.02), 0.25, 0.2);
	Out.ar([0, 1], sig);
}).add;
)

~synth = Synth(\photosaw, [\cutoff, ~val.linexp(0, 1023, 80, 4000)]);
~synth.free;

(
~control = Routine({
	{
		~synth.set(\cutoff, ~val.linexp(0, 1023, 80, 4000));
		0.01.wait;
	}.loop;
}).play;
)
~control.stop;