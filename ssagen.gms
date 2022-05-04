set inputs /target,rebate,metric/; 
file kgen /'ssainputs.gen'/; put kgen; kgen.lw=0;
loop(inputs, 
	put "' --",inputs.tl,"=',",inputs.tl,".tl"; 
	if (ord(inputs)<card(inputs), 
	  put ','/;
	else
	  put "/;"
	);
);
