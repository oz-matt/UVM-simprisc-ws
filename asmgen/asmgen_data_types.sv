typedef struct {
	string name;
	instruction_base_si ins[$];
} asm_subsection_t;

typedef struct {
	string name;
	asm_subsection_t subsection[$];
} asm_section_t;