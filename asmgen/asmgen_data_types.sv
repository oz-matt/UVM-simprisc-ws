typedef struct packed {
	string name;
	instruction_base_si ins[$];
} asm_subsection_s;

typedef struct packed {
	string name;
	asm_subsection_s subsection[$];
} asm_section_s;