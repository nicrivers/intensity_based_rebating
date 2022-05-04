set inputs /target,rebate,metric/; 
file nsdef /'ssa_eval.gms'/; put nsdef; nsdef.lw=0;
put '$eval ns ';
loop(inputs,
	if (ord(inputs)<card(inputs),
	  put 'card(',inputs.tl,')*';
	else
	  put 'card(',inputs.tl,')';
	);
);
put /;
put '$setglobal ns %ns%'/;
