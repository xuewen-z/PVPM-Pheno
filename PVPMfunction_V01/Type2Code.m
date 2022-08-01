function Code=Type2Code(Type)

Code  =nan(size(Type));

Code(strcmp('ENF',Type))=1;
Code(strcmp('EBF',Type))=2;
Code(strcmp('DNF',Type))=3;
Code(strcmp('DBF',Type))=4;
Code(strcmp('MIF',Type))=5;
Code(strcmp('CSH',Type))=6;
Code(strcmp('OSH',Type))=7;
Code(strcmp('WSA',Type))=8;
Code(strcmp('SAV',Type))=9;
Code(strcmp('GRA',Type))=10;
Code(strcmp('CRO',Type))=12;

end