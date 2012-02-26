/* A Bison parser, made by GNU Bison 1.875d.  */

/* Skeleton parser for Yacc-like parsing with Bison,
   Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004 Free Software Foundation, Inc.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2, or (at your option)
   any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 59 Temple Place - Suite 330,
   Boston, MA 02111-1307, USA.  */

/* As a special exception, when this file is copied by Bison into a
   Bison output file, you may use that output file without restriction.
   This special exception was added by the Free Software Foundation
   in version 1.24 of Bison.  */

/* Written by Richard Stallman by simplifying the original so called
   ``semantic'' parser.  */

/* All symbols defined below should begin with yy or YY, to avoid
   infringing on user name space.  This should be done even for local
   variables, as they might otherwise be expanded by user macros.
   There are some unavoidable exceptions within include files to
   define necessary library symbols; they are noted "INFRINGES ON
   USER NAME SPACE" below.  */

/* Identify Bison output.  */
#define YYBISON 1

/* Skeleton name.  */
#define YYSKELETON_NAME "yacc.c"

/* Pure parsers.  */
#define YYPURE 1

/* Using locations.  */
#define YYLSP_NEEDED 0

/* If NAME_PREFIX is specified substitute the variables and functions
   names.  */
#define yyparse STCparse
#define yylex   STClex
#define yyerror STCerror
#define yylval  STClval
#define yychar  STCchar
#define yydebug STCdebug
#define yynerrs STCnerrs


/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     TK_SEPARATOR = 258,
     TK_BAR = 259,
     TK_ASSIGNMENT = 260,
     TK_LPAREN = 261,
     TK_RPAREN = 262,
     TK_BLOCK_OPEN = 263,
     TK_BLOCK_CLOSE = 264,
     TK_ARRAY_OPEN = 265,
     TK_DOT = 266,
     TK_COLON = 267,
     TK_SEMICOLON = 268,
     TK_RETURN = 269,
     TK_IDENTIFIER = 270,
     TK_BINARY_SELECTOR = 271,
     TK_KEYWORD = 272,
     TK_INTNUMBER = 273,
     TK_REALNUMBER = 274,
     TK_SYMBOL = 275,
     TK_STRING = 276,
     TK_CHARACTER = 277
   };
#endif
#define TK_SEPARATOR 258
#define TK_BAR 259
#define TK_ASSIGNMENT 260
#define TK_LPAREN 261
#define TK_RPAREN 262
#define TK_BLOCK_OPEN 263
#define TK_BLOCK_CLOSE 264
#define TK_ARRAY_OPEN 265
#define TK_DOT 266
#define TK_COLON 267
#define TK_SEMICOLON 268
#define TK_RETURN 269
#define TK_IDENTIFIER 270
#define TK_BINARY_SELECTOR 271
#define TK_KEYWORD 272
#define TK_INTNUMBER 273
#define TK_REALNUMBER 274
#define TK_SYMBOL 275
#define TK_STRING 276
#define TK_CHARACTER 277




/* Copy the first part of user declarations.  */
#line 25 "STGrammar.y"


    #define YYSTYPE id
    #define YYLTYPE int
    #undef YYDEBUG
    
    #import <Foundation/NSException.h>
    #import "STCompiler.h"
    #import "STCompilerUtils.h"
    #import "STSourceReader.h"
    #import "Externs.h"
    
    #import <StepTalk/STExterns.h>


/* extern int STCerror(const char *str);
   extern int STClex (YYSTYPE *lvalp, void *context);
*/
    #define YYPARSE_PARAM    context
    #define YYLEX_PARAM      context
    #define YYERROR_VERBOSE

    #define CONTEXT ((STParserContext *)context)
    #define COMPILER (CONTEXT->compiler)
    #define READER   (CONTEXT->reader)
    #define RESULT   (CONTEXT->result)

    int STClex (YYSTYPE *lvalp, void *context);
    int STCerror(const char *str);


/* Enabling traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif

/* Enabling verbose error messages.  */
#ifdef YYERROR_VERBOSE
# undef YYERROR_VERBOSE
# define YYERROR_VERBOSE 1
#else
# define YYERROR_VERBOSE 0
#endif

#if ! defined (YYSTYPE) && ! defined (YYSTYPE_IS_DECLARED)
typedef int YYSTYPE;
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif



/* Copy the second part of user declarations.  */


/* Line 214 of yacc.c.  */
#line 171 "STGrammar.m"

#if ! defined (yyoverflow) || YYERROR_VERBOSE

# ifndef YYFREE
#  define YYFREE free
# endif
# ifndef YYMALLOC
#  define YYMALLOC malloc
# endif

/* The parser invokes alloca or malloc; define the necessary symbols.  */

# ifdef YYSTACK_USE_ALLOCA
#  if YYSTACK_USE_ALLOCA
#   define YYSTACK_ALLOC alloca
#  endif
# else
#  if defined (alloca) || defined (_ALLOCA_H)
#   define YYSTACK_ALLOC alloca
#  else
#   ifdef __GNUC__
#    define YYSTACK_ALLOC __builtin_alloca
#   endif
#  endif
# endif

# ifdef YYSTACK_ALLOC
   /* Pacify GCC's `empty if-body' warning. */
#  define YYSTACK_FREE(Ptr) do { /* empty */; } while (0)
# else
#  if defined (__STDC__) || defined (__cplusplus)
#   include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#   define YYSIZE_T size_t
#  endif
#  define YYSTACK_ALLOC YYMALLOC
#  define YYSTACK_FREE YYFREE
# endif
#endif /* ! defined (yyoverflow) || YYERROR_VERBOSE */


#if (! defined (yyoverflow) \
     && (! defined (__cplusplus) \
	 || (defined (YYSTYPE_IS_TRIVIAL) && YYSTYPE_IS_TRIVIAL)))

/* A type that is properly aligned for any stack member.  */
union yyalloc
{
  short int yyss;
  YYSTYPE yyvs;
  };

/* The size of the maximum gap between one aligned stack and the next.  */
# define YYSTACK_GAP_MAXIMUM (sizeof (union yyalloc) - 1)

/* The size of an array large to enough to hold all stacks, each with
   N elements.  */
# define YYSTACK_BYTES(N) \
     ((N) * (sizeof (short int) + sizeof (YYSTYPE))			\
      + YYSTACK_GAP_MAXIMUM)

/* Copy COUNT objects from FROM to TO.  The source and destination do
   not overlap.  */
# ifndef YYCOPY
#  if defined (__GNUC__) && 1 < __GNUC__
#   define YYCOPY(To, From, Count) \
      __builtin_memcpy (To, From, (Count) * sizeof (*(From)))
#  else
#   define YYCOPY(To, From, Count)		\
      do					\
	{					\
	  register YYSIZE_T yyi;		\
	  for (yyi = 0; yyi < (Count); yyi++)	\
	    (To)[yyi] = (From)[yyi];		\
	}					\
      while (0)
#  endif
# endif

/* Relocate STACK from its old location to the new one.  The
   local variables YYSIZE and YYSTACKSIZE give the old and new number of
   elements in the stack, and YYPTR gives the new location of the
   stack.  Advance YYPTR to a properly aligned location for the next
   stack.  */
# define YYSTACK_RELOCATE(Stack)					\
    do									\
      {									\
	YYSIZE_T yynewbytes;						\
	YYCOPY (&yyptr->Stack, Stack, yysize);				\
	Stack = &yyptr->Stack;						\
	yynewbytes = yystacksize * sizeof (*Stack) + YYSTACK_GAP_MAXIMUM; \
	yyptr += yynewbytes / sizeof (*yyptr);				\
      }									\
    while (0)

#endif

#if defined (__STDC__) || defined (__cplusplus)
   typedef signed char yysigned_char;
#else
   typedef short int yysigned_char;
#endif

/* YYFINAL -- State number of the termination state. */
#define YYFINAL  50
/* YYLAST -- Last index in YYTABLE.  */
#define YYLAST   244

/* YYNTOKENS -- Number of terminals. */
#define YYNTOKENS  23
/* YYNNTS -- Number of nonterminals. */
#define YYNNTS  37
/* YYNRULES -- Number of rules. */
#define YYNRULES  83
/* YYNRULES -- Number of states. */
#define YYNSTATES  120

/* YYTRANSLATE(YYLEX) -- Bison symbol number corresponding to YYLEX.  */
#define YYUNDEFTOK  2
#define YYMAXUTOK   277

#define YYTRANSLATE(YYX) 						\
  ((unsigned int) (YYX) <= YYMAXUTOK ? yytranslate[YYX] : YYUNDEFTOK)

/* YYTRANSLATE[YYLEX] -- Bison symbol number corresponding to YYLEX.  */
static const unsigned char yytranslate[] =
{
       0,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     1,     2,     3,     4,
       5,     6,     7,     8,     9,    10,    11,    12,    13,    14,
      15,    16,    17,    18,    19,    20,    21,    22
};

#if YYDEBUG
/* YYPRHS[YYN] -- Index of the first RHS symbol of rule number YYN in
   YYRHS.  */
static const unsigned char yyprhs[] =
{
       0,     0,     3,     4,     6,    10,    11,    17,    19,    22,
      23,    27,    29,    31,    35,    38,    42,    44,    47,    49,
      52,    56,    60,    62,    65,    68,    72,    78,    81,    85,
      88,    90,    93,    98,   100,   104,   106,   109,   111,   114,
     116,   119,   121,   124,   127,   130,   133,   137,   139,   142,
     144,   146,   148,   150,   153,   157,   160,   163,   167,   169,
     171,   173,   175,   177,   179,   181,   185,   187,   189,   191,
     193,   195,   197,   199,   201,   203,   207,   208,   210,   212,
     215,   218,   220,   222
};

/* YYRHS -- A `-1'-separated list of the rules' RHS. */
static const yysigned_char yyrhs[] =
{
      24,     0,    -1,    -1,    26,    -1,     3,     3,    30,    -1,
      -1,     8,     4,    25,    27,     9,    -1,    37,    -1,    33,
      37,    -1,    -1,    36,    28,    29,    -1,    29,    -1,    30,
      -1,    29,     3,    30,    -1,    31,    37,    -1,    31,    33,
      37,    -1,    54,    -1,    55,    53,    -1,    32,    -1,    56,
      53,    -1,    32,    56,    53,    -1,     4,    34,     4,    -1,
      53,    -1,    34,    53,    -1,     8,     9,    -1,     8,    37,
       9,    -1,     8,    36,     4,    37,     9,    -1,    12,    53,
      -1,    36,    12,    53,    -1,    14,    39,    -1,    38,    -1,
      38,    11,    -1,    38,    11,    14,    39,    -1,    39,    -1,
      38,    11,    39,    -1,    52,    -1,    40,    52,    -1,    45,
      -1,    40,    45,    -1,    42,    -1,    40,    42,    -1,    41,
      -1,    40,    41,    -1,    53,     5,    -1,    45,    43,    -1,
      13,    44,    -1,    43,    13,    44,    -1,    54,    -1,    55,
      50,    -1,    49,    -1,    46,    -1,    47,    -1,    48,    -1,
      50,    54,    -1,    51,    55,    50,    -1,    51,    49,    -1,
      56,    51,    -1,    49,    56,    51,    -1,    52,    -1,    46,
      -1,    50,    -1,    47,    -1,    53,    -1,    57,    -1,    35,
      -1,     6,    39,     7,    -1,    15,    -1,    15,    -1,    16,
      -1,    17,    -1,    18,    -1,    19,    -1,    20,    -1,    21,
      -1,    22,    -1,    10,    58,     7,    -1,    -1,    57,    -1,
      59,    -1,    58,    57,    -1,    58,    59,    -1,    15,    -1,
      55,    -1,    17,    -1
};

/* YYRLINE[YYN] -- source line where rule number YYN was defined.  */
static const unsigned short int yyrline[] =
{
       0,    69,    69,    74,    79,    86,    85,    93,    98,   108,
     107,   113,   116,   120,   126,   131,   140,   145,   150,   153,
     158,   165,   169,   174,   181,   185,   189,   195,   200,   207,
     212,   218,   223,   232,   237,   243,   248,   254,   255,   260,
     261,   267,   272,   279,   282,   288,   293,   299,   304,   309,
     312,   313,   314,   316,   325,   334,   341,   346,   352,   353,
     355,   356,   358,   362,   366,   370,   375,   377,   379,   381,
     384,   386,   388,   390,   392,   394,   397,   398,   400,   402,
     403,   405,   407,   409
};
#endif

#if YYDEBUG || YYERROR_VERBOSE
/* YYTNME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
   First, the terminals, then, starting at YYNTOKENS, nonterminals. */
static const char *const yytname[] =
{
  "$end", "error", "$undefined", "TK_SEPARATOR", "TK_BAR",
  "TK_ASSIGNMENT", "TK_LPAREN", "TK_RPAREN", "TK_BLOCK_OPEN",
  "TK_BLOCK_CLOSE", "TK_ARRAY_OPEN", "TK_DOT", "TK_COLON", "TK_SEMICOLON",
  "TK_RETURN", "TK_IDENTIFIER", "TK_BINARY_SELECTOR", "TK_KEYWORD",
  "TK_INTNUMBER", "TK_REALNUMBER", "TK_SYMBOL", "TK_STRING",
  "TK_CHARACTER", "$accept", "source", "@1", "plain_code", "methods", "@2",
  "method_list", "method", "message_pattern", "keyword_list",
  "temporaries", "variable_list", "block", "block_var_list", "statements",
  "expressions", "expression", "assignments", "assignment", "cascade",
  "cascade_list", "cascade_item", "message_expression", "unary_expression",
  "binary_expression", "keyword_expression", "keyword_expr_list",
  "unary_object", "binary_object", "primary", "variable_name",
  "unary_selector", "binary_selector", "keyword", "literal", "array",
  "symbol", 0
};
#endif

# ifdef YYPRINT
/* YYTOKNUM[YYLEX-NUM] -- Internal token number corresponding to
   token YYLEX-NUM.  */
static const unsigned short int yytoknum[] =
{
       0,   256,   257,   258,   259,   260,   261,   262,   263,   264,
     265,   266,   267,   268,   269,   270,   271,   272,   273,   274,
     275,   276,   277
};
# endif

/* YYR1[YYN] -- Symbol number of symbol that rule YYN derives.  */
static const unsigned char yyr1[] =
{
       0,    23,    24,    24,    24,    25,    24,    26,    26,    28,
      27,    27,    29,    29,    30,    30,    31,    31,    31,    32,
      32,    33,    34,    34,    35,    35,    35,    36,    36,    37,
      37,    37,    37,    38,    38,    39,    39,    39,    39,    39,
      39,    40,    40,    41,    42,    43,    43,    44,    44,    44,
      45,    45,    45,    46,    47,    48,    49,    49,    50,    50,
      51,    51,    52,    52,    52,    52,    53,    54,    55,    56,
      57,    57,    57,    57,    57,    57,    58,    58,    58,    58,
      58,    59,    59,    59
};

/* YYR2[YYN] -- Number of symbols composing right hand side of rule YYN.  */
static const unsigned char yyr2[] =
{
       0,     2,     0,     1,     3,     0,     5,     1,     2,     0,
       3,     1,     1,     3,     2,     3,     1,     2,     1,     2,
       3,     3,     1,     2,     2,     3,     5,     2,     3,     2,
       1,     2,     4,     1,     3,     1,     2,     1,     2,     1,
       2,     1,     2,     2,     2,     2,     3,     1,     2,     1,
       1,     1,     1,     2,     3,     2,     2,     3,     1,     1,
       1,     1,     1,     1,     1,     3,     1,     1,     1,     1,
       1,     1,     1,     1,     1,     3,     0,     1,     1,     2,
       2,     1,     1,     1
};

/* YYDEFACT[STATE-NAME] -- Default rule to reduce with in state
   STATE-NUM when YYTABLE doesn't specify something else to do.  Zero
   means the default is an error.  */
static const unsigned char yydefact[] =
{
       2,     0,     0,     0,     0,    76,     0,    66,    70,    71,
      72,    73,    74,     0,     3,     0,    64,     7,    30,    33,
       0,    41,    39,    37,    50,    51,    52,    60,     0,    35,
      62,    63,     0,     0,    22,     0,     0,     5,    24,     0,
       0,     0,    81,    68,    83,    82,    77,     0,    78,    29,
       1,     8,    31,    42,    40,    38,    36,     0,    44,    67,
      53,    69,    55,     0,     0,    43,     4,     0,    18,    16,
       0,     0,    21,    23,    65,     0,    27,     0,     0,    25,
      75,    79,    80,     0,    34,    45,    49,    47,     0,     0,
       0,    59,    54,    58,    62,    61,    56,     0,    14,     0,
      17,    19,     0,    11,    12,     9,     0,    28,    32,    48,
      46,    57,    15,    20,     6,     0,     0,    26,    13,    10
};

/* YYDEFGOTO[NTERM-NUM]. */
static const yysigned_char yydefgoto[] =
{
      -1,    13,    75,    14,   102,   116,   103,   104,    67,    68,
      15,    33,    16,    40,    41,    18,    19,    20,    21,    22,
      58,    85,    23,    24,    25,    26,    86,    27,    28,    29,
      30,    69,    70,    71,    31,    47,    48
};

/* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
   STATE-NUM.  */
#define YYPACT_NINF -60
static const short int yypact[] =
{
     104,    11,     0,    38,   123,   222,    38,   -60,   -60,   -60,
     -60,   -60,   -60,    17,   -60,   176,   -60,   -60,     9,   -60,
      38,   -60,   -60,     8,    34,    10,   -60,    18,    50,    78,
      49,   -60,   100,     7,   -60,   159,    54,   -60,   -60,     0,
      12,    55,   -60,   -60,   -60,   -60,   -60,   209,   -60,   -60,
     -60,   -60,   193,   -60,   -60,     8,    78,   100,    60,   -60,
     -60,   -60,    57,    38,    38,   -60,   -60,   142,    57,   -60,
       0,     0,   -60,   -60,   -60,    13,   -60,   176,     0,   -60,
     -60,   -60,   -60,    38,   -60,   -60,    57,   -60,    38,   100,
      38,   -60,    18,   -60,   -60,   -60,    64,   176,   -60,     0,
     -60,   -60,    67,    79,   -60,    71,    81,   -60,   -60,    18,
     -60,    64,   -60,   -60,   -60,   100,   100,   -60,   -60,    79
};

/* YYPGOTO[NTERM-NUM].  */
static const yysigned_char yypgoto[] =
{
     -60,   -60,   -60,   -60,   -60,   -60,   -28,   -30,   -60,   -60,
      29,   -60,   -60,    22,     4,   -60,     3,   -60,    80,    82,
     -60,    20,    84,   -51,   -59,   -60,    83,   -45,   -56,    15,
      -1,   -17,    -5,   -21,    -2,   -60,    52
};

/* YYTABLE[YYPACT[STATE-NUM]].  What to do in state STATE-NUM.  If
   positive, shift that token.  If negative, reduce the rule which
   number is the opposite.  If zero, do what YYDEFACT says.
   If YYTABLE_NINF, syntax error.  */
#define YYTABLE_NINF -62
static const yysigned_char yytable[] =
{
      45,    34,    66,    46,    17,    95,    36,    64,    96,    49,
      60,    72,    91,    91,    32,     7,    77,    50,    92,    51,
      52,    57,     7,    63,    78,    39,   -61,   -61,    59,    43,
      61,    95,    73,    59,   111,    56,    64,    91,    76,    91,
      87,    90,    45,   109,     3,    81,    35,    99,     5,   -59,
     -59,   -59,    88,     7,    65,    84,     8,     9,    10,    11,
      12,    74,    94,    94,    79,    90,    43,    61,    64,   100,
     101,    98,    87,    89,    61,    60,   114,   107,    93,    93,
      43,   106,   115,    78,    88,   118,   108,    94,   119,    94,
     117,    63,    60,   -58,   -58,   -58,    97,   105,   113,    82,
      53,   112,    54,    93,    55,    93,    63,     1,     2,   110,
       3,    62,     4,     0,     5,    59,    43,    61,     6,     7,
       0,     0,     8,     9,    10,    11,    12,    37,     0,     3,
       0,    35,    38,     5,     0,    39,     0,     6,     7,     0,
       0,     8,     9,    10,    11,    12,     2,     0,     3,     0,
      35,     0,     5,     0,     0,     0,     6,     7,     0,     0,
       8,     9,    10,    11,    12,     3,     0,    35,    38,     5,
       0,    39,     0,     6,     7,     0,     0,     8,     9,    10,
      11,    12,     3,     0,    35,     0,     5,     0,     0,     0,
       6,     7,     0,     0,     8,     9,    10,    11,    12,     3,
       0,    35,     0,     5,     0,     0,     0,    83,     7,     0,
       0,     8,     9,    10,    11,    12,    80,     0,     0,     5,
       0,     0,     0,     0,    42,    43,    44,     8,     9,    10,
      11,    12,     5,     0,     0,     0,     0,    42,    43,    44,
       8,     9,    10,    11,    12
};

static const yysigned_char yycheck[] =
{
       5,     2,    32,     5,     0,    64,     3,    28,    64,     6,
      27,     4,    63,    64,     3,    15,     4,     0,    63,    15,
      11,    13,    15,    28,    12,    12,    16,    17,    15,    16,
      17,    90,    33,    15,    90,    20,    57,    88,    39,    90,
      57,    62,    47,    88,     6,    47,     8,    68,    10,    15,
      16,    17,    57,    15,     5,    52,    18,    19,    20,    21,
      22,     7,    63,    64,     9,    86,    16,    17,    89,    70,
      71,    67,    89,    13,    17,    92,     9,    78,    63,    64,
      16,    77,     3,    12,    89,   115,    83,    88,   116,    90,
       9,    96,   109,    15,    16,    17,    67,    75,    99,    47,
      20,    97,    20,    88,    20,    90,   111,     3,     4,    89,
       6,    28,     8,    -1,    10,    15,    16,    17,    14,    15,
      -1,    -1,    18,    19,    20,    21,    22,     4,    -1,     6,
      -1,     8,     9,    10,    -1,    12,    -1,    14,    15,    -1,
      -1,    18,    19,    20,    21,    22,     4,    -1,     6,    -1,
       8,    -1,    10,    -1,    -1,    -1,    14,    15,    -1,    -1,
      18,    19,    20,    21,    22,     6,    -1,     8,     9,    10,
      -1,    12,    -1,    14,    15,    -1,    -1,    18,    19,    20,
      21,    22,     6,    -1,     8,    -1,    10,    -1,    -1,    -1,
      14,    15,    -1,    -1,    18,    19,    20,    21,    22,     6,
      -1,     8,    -1,    10,    -1,    -1,    -1,    14,    15,    -1,
      -1,    18,    19,    20,    21,    22,     7,    -1,    -1,    10,
      -1,    -1,    -1,    -1,    15,    16,    17,    18,    19,    20,
      21,    22,    10,    -1,    -1,    -1,    -1,    15,    16,    17,
      18,    19,    20,    21,    22
};

/* YYSTOS[STATE-NUM] -- The (internal number of the) accessing
   symbol of state STATE-NUM.  */
static const unsigned char yystos[] =
{
       0,     3,     4,     6,     8,    10,    14,    15,    18,    19,
      20,    21,    22,    24,    26,    33,    35,    37,    38,    39,
      40,    41,    42,    45,    46,    47,    48,    50,    51,    52,
      53,    57,     3,    34,    53,     8,    39,     4,     9,    12,
      36,    37,    15,    16,    17,    55,    57,    58,    59,    39,
       0,    37,    11,    41,    42,    45,    52,    13,    43,    15,
      54,    17,    49,    55,    56,     5,    30,    31,    32,    54,
      55,    56,     4,    53,     7,    25,    53,     4,    12,     9,
       7,    57,    59,    14,    39,    44,    49,    54,    55,    13,
      56,    46,    50,    52,    53,    47,    51,    33,    37,    56,
      53,    53,    27,    29,    30,    36,    37,    53,    39,    50,
      44,    51,    37,    53,     9,     3,    28,     9,    30,    29
};

#if ! defined (YYSIZE_T) && defined (__SIZE_TYPE__)
# define YYSIZE_T __SIZE_TYPE__
#endif
#if ! defined (YYSIZE_T) && defined (size_t)
# define YYSIZE_T size_t
#endif
#if ! defined (YYSIZE_T)
# if defined (__STDC__) || defined (__cplusplus)
#  include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  define YYSIZE_T size_t
# endif
#endif
#if ! defined (YYSIZE_T)
# define YYSIZE_T unsigned int
#endif

#define yyerrok		(yyerrstatus = 0)
#define yyclearin	(yychar = YYEMPTY)
#define YYEMPTY		(-2)
#define YYEOF		0

#define YYACCEPT	goto yyacceptlab
#define YYABORT		goto yyabortlab
#define YYERROR		goto yyerrorlab


/* Like YYERROR except do call yyerror.  This remains here temporarily
   to ease the transition to the new meaning of YYERROR, for GCC.
   Once GCC version 2 has supplanted version 1, this can go.  */

#define YYFAIL		goto yyerrlab

#define YYRECOVERING()  (!!yyerrstatus)

#define YYBACKUP(Token, Value)					\
do								\
  if (yychar == YYEMPTY && yylen == 1)				\
    {								\
      yychar = (Token);						\
      yylval = (Value);						\
      yytoken = YYTRANSLATE (yychar);				\
      YYPOPSTACK;						\
      goto yybackup;						\
    }								\
  else								\
    { 								\
      yyerror ("syntax error: cannot back up");\
      YYERROR;							\
    }								\
while (0)

#define YYTERROR	1
#define YYERRCODE	256

/* YYLLOC_DEFAULT -- Compute the default location (before the actions
   are run).  */

#ifndef YYLLOC_DEFAULT
# define YYLLOC_DEFAULT(Current, Rhs, N)		\
   ((Current).first_line   = (Rhs)[1].first_line,	\
    (Current).first_column = (Rhs)[1].first_column,	\
    (Current).last_line    = (Rhs)[N].last_line,	\
    (Current).last_column  = (Rhs)[N].last_column)
#endif

/* YYLEX -- calling `yylex' with the right arguments.  */

#ifdef YYLEX_PARAM
# define YYLEX yylex (&yylval, YYLEX_PARAM)
#else
# define YYLEX yylex (&yylval)
#endif

/* Enable debugging if requested.  */
#if YYDEBUG

# ifndef YYFPRINTF
#  include <stdio.h> /* INFRINGES ON USER NAME SPACE */
#  define YYFPRINTF fprintf
# endif

# define YYDPRINTF(Args)			\
do {						\
  if (yydebug)					\
    YYFPRINTF Args;				\
} while (0)

# define YYDSYMPRINT(Args)			\
do {						\
  if (yydebug)					\
    yysymprint Args;				\
} while (0)

# define YYDSYMPRINTF(Title, Token, Value, Location)		\
do {								\
  if (yydebug)							\
    {								\
      YYFPRINTF (stderr, "%s ", Title);				\
      yysymprint (stderr, 					\
                  Token, Value);	\
      YYFPRINTF (stderr, "\n");					\
    }								\
} while (0)

/*------------------------------------------------------------------.
| yy_stack_print -- Print the state stack from its BOTTOM up to its |
| TOP (included).                                                   |
`------------------------------------------------------------------*/

#if defined (__STDC__) || defined (__cplusplus)
static void
yy_stack_print (short int *bottom, short int *top)
#else
static void
yy_stack_print (bottom, top)
    short int *bottom;
    short int *top;
#endif
{
  YYFPRINTF (stderr, "Stack now");
  for (/* Nothing. */; bottom <= top; ++bottom)
    YYFPRINTF (stderr, " %d", *bottom);
  YYFPRINTF (stderr, "\n");
}

# define YY_STACK_PRINT(Bottom, Top)				\
do {								\
  if (yydebug)							\
    yy_stack_print ((Bottom), (Top));				\
} while (0)


/*------------------------------------------------.
| Report that the YYRULE is going to be reduced.  |
`------------------------------------------------*/

#if defined (__STDC__) || defined (__cplusplus)
static void
yy_reduce_print (int yyrule)
#else
static void
yy_reduce_print (yyrule)
    int yyrule;
#endif
{
  int yyi;
  unsigned int yylno = yyrline[yyrule];
  YYFPRINTF (stderr, "Reducing stack by rule %d (line %u), ",
             yyrule - 1, yylno);
  /* Print the symbols being reduced, and their result.  */
  for (yyi = yyprhs[yyrule]; 0 <= yyrhs[yyi]; yyi++)
    YYFPRINTF (stderr, "%s ", yytname [yyrhs[yyi]]);
  YYFPRINTF (stderr, "-> %s\n", yytname [yyr1[yyrule]]);
}

# define YY_REDUCE_PRINT(Rule)		\
do {					\
  if (yydebug)				\
    yy_reduce_print (Rule);		\
} while (0)

/* Nonzero means print parse trace.  It is left uninitialized so that
   multiple parsers can coexist.  */
int yydebug;
#else /* !YYDEBUG */
# define YYDPRINTF(Args)
# define YYDSYMPRINT(Args)
# define YYDSYMPRINTF(Title, Token, Value, Location)
# define YY_STACK_PRINT(Bottom, Top)
# define YY_REDUCE_PRINT(Rule)
#endif /* !YYDEBUG */


/* YYINITDEPTH -- initial size of the parser's stacks.  */
#ifndef	YYINITDEPTH
# define YYINITDEPTH 200
#endif

/* YYMAXDEPTH -- maximum size the stacks can grow to (effective only
   if the built-in stack extension method is used).

   Do not make this value too large; the results are undefined if
   SIZE_MAX < YYSTACK_BYTES (YYMAXDEPTH)
   evaluated with infinite-precision integer arithmetic.  */

#if defined (YYMAXDEPTH) && YYMAXDEPTH == 0
# undef YYMAXDEPTH
#endif

#ifndef YYMAXDEPTH
# define YYMAXDEPTH 10000
#endif



#if YYERROR_VERBOSE

# ifndef yystrlen
#  if defined (__GLIBC__) && defined (_STRING_H)
#   define yystrlen strlen
#  else
/* Return the length of YYSTR.  */
static YYSIZE_T
#   if defined (__STDC__) || defined (__cplusplus)
yystrlen (const char *yystr)
#   else
yystrlen (yystr)
     const char *yystr;
#   endif
{
  register const char *yys = yystr;

  while (*yys++ != '\0')
    continue;

  return yys - yystr - 1;
}
#  endif
# endif

# ifndef yystpcpy
#  if defined (__GLIBC__) && defined (_STRING_H) && defined (_GNU_SOURCE)
#   define yystpcpy stpcpy
#  else
/* Copy YYSRC to YYDEST, returning the address of the terminating '\0' in
   YYDEST.  */
static char *
#   if defined (__STDC__) || defined (__cplusplus)
yystpcpy (char *yydest, const char *yysrc)
#   else
yystpcpy (yydest, yysrc)
     char *yydest;
     const char *yysrc;
#   endif
{
  register char *yyd = yydest;
  register const char *yys = yysrc;

  while ((*yyd++ = *yys++) != '\0')
    continue;

  return yyd - 1;
}
#  endif
# endif

#endif /* !YYERROR_VERBOSE */



#if YYDEBUG
/*--------------------------------.
| Print this symbol on YYOUTPUT.  |
`--------------------------------*/

#if defined (__STDC__) || defined (__cplusplus)
static void
yysymprint (FILE *yyoutput, int yytype, YYSTYPE *yyvaluep)
#else
static void
yysymprint (yyoutput, yytype, yyvaluep)
    FILE *yyoutput;
    int yytype;
    YYSTYPE *yyvaluep;
#endif
{
  /* Pacify ``unused variable'' warnings.  */
  (void) yyvaluep;

  if (yytype < YYNTOKENS)
    {
      YYFPRINTF (yyoutput, "token %s (", yytname[yytype]);
# ifdef YYPRINT
      YYPRINT (yyoutput, yytoknum[yytype], *yyvaluep);
# endif
    }
  else
    YYFPRINTF (yyoutput, "nterm %s (", yytname[yytype]);

  switch (yytype)
    {
      default:
        break;
    }
  YYFPRINTF (yyoutput, ")");
}

#endif /* ! YYDEBUG */
/*-----------------------------------------------.
| Release the memory associated to this symbol.  |
`-----------------------------------------------*/

#if defined (__STDC__) || defined (__cplusplus)
static void
yydestruct (int yytype, YYSTYPE *yyvaluep)
#else
static void
yydestruct (yytype, yyvaluep)
    int yytype;
    YYSTYPE *yyvaluep;
#endif
{
  /* Pacify ``unused variable'' warnings.  */
  (void) yyvaluep;

  switch (yytype)
    {

      default:
        break;
    }
}


/* Prevent warnings from -Wmissing-prototypes.  */

#ifdef YYPARSE_PARAM
# if defined (__STDC__) || defined (__cplusplus)
int yyparse (void *YYPARSE_PARAM);
# else
int yyparse ();
# endif
#else /* ! YYPARSE_PARAM */
#if defined (__STDC__) || defined (__cplusplus)
int yyparse (void);
#else
int yyparse ();
#endif
#endif /* ! YYPARSE_PARAM */






/*----------.
| yyparse.  |
`----------*/

#ifdef YYPARSE_PARAM
# if defined (__STDC__) || defined (__cplusplus)
int yyparse (void *YYPARSE_PARAM)
# else
int yyparse (YYPARSE_PARAM)
  void *YYPARSE_PARAM;
# endif
#else /* ! YYPARSE_PARAM */
#if defined (__STDC__) || defined (__cplusplus)
int
yyparse (void)
#else
int
yyparse ()

#endif
#endif
{
  /* The lookahead symbol.  */
int yychar;

/* The semantic value of the lookahead symbol.  */
YYSTYPE yylval;

/* Number of syntax errors so far.  */
int yynerrs;

  register int yystate;
  register int yyn;
  int yyresult;
  /* Number of tokens to shift before error messages enabled.  */
  int yyerrstatus;
  /* Lookahead token as an internal (translated) token number.  */
  int yytoken = 0;

  /* Three stacks and their tools:
     `yyss': related to states,
     `yyvs': related to semantic values,
     `yyls': related to locations.

     Refer to the stacks thru separate pointers, to allow yyoverflow
     to reallocate them elsewhere.  */

  /* The state stack.  */
  short int yyssa[YYINITDEPTH];
  short int *yyss = yyssa;
  register short int *yyssp;

  /* The semantic value stack.  */
  YYSTYPE yyvsa[YYINITDEPTH];
  YYSTYPE *yyvs = yyvsa;
  register YYSTYPE *yyvsp;



#define YYPOPSTACK   (yyvsp--, yyssp--)

  YYSIZE_T yystacksize = YYINITDEPTH;

  /* The variables used to return semantic value and location from the
     action routines.  */
  YYSTYPE yyval;


  /* When reducing, the number of symbols on the RHS of the reduced
     rule.  */
  int yylen;

  YYDPRINTF ((stderr, "Starting parse\n"));

  yystate = 0;
  yyerrstatus = 0;
  yynerrs = 0;
  yychar = YYEMPTY;		/* Cause a token to be read.  */

  /* Initialize stack pointers.
     Waste one element of value and location stack
     so that they stay on the same level as the state stack.
     The wasted elements are never initialized.  */

  yyssp = yyss;
  yyvsp = yyvs;


  goto yysetstate;

/*------------------------------------------------------------.
| yynewstate -- Push a new state, which is found in yystate.  |
`------------------------------------------------------------*/
 yynewstate:
  /* In all cases, when you get here, the value and location stacks
     have just been pushed. so pushing a state here evens the stacks.
     */
  yyssp++;

 yysetstate:
  *yyssp = yystate;

  if (yyss + yystacksize - 1 <= yyssp)
    {
      /* Get the current used size of the three stacks, in elements.  */
      YYSIZE_T yysize = yyssp - yyss + 1;

#ifdef yyoverflow
      {
	/* Give user a chance to reallocate the stack. Use copies of
	   these so that the &'s don't force the real ones into
	   memory.  */
	YYSTYPE *yyvs1 = yyvs;
	short int *yyss1 = yyss;


	/* Each stack pointer address is followed by the size of the
	   data in use in that stack, in bytes.  This used to be a
	   conditional around just the two extra args, but that might
	   be undefined if yyoverflow is a macro.  */
	yyoverflow ("parser stack overflow",
		    &yyss1, yysize * sizeof (*yyssp),
		    &yyvs1, yysize * sizeof (*yyvsp),

		    &yystacksize);

	yyss = yyss1;
	yyvs = yyvs1;
      }
#else /* no yyoverflow */
# ifndef YYSTACK_RELOCATE
      goto yyoverflowlab;
# else
      /* Extend the stack our own way.  */
      if (YYMAXDEPTH <= yystacksize)
	goto yyoverflowlab;
      yystacksize *= 2;
      if (YYMAXDEPTH < yystacksize)
	yystacksize = YYMAXDEPTH;

      {
	short int *yyss1 = yyss;
	union yyalloc *yyptr =
	  (union yyalloc *) YYSTACK_ALLOC (YYSTACK_BYTES (yystacksize));
	if (! yyptr)
	  goto yyoverflowlab;
	YYSTACK_RELOCATE (yyss);
	YYSTACK_RELOCATE (yyvs);

#  undef YYSTACK_RELOCATE
	if (yyss1 != yyssa)
	  YYSTACK_FREE (yyss1);
      }
# endif
#endif /* no yyoverflow */

      yyssp = yyss + yysize - 1;
      yyvsp = yyvs + yysize - 1;


      YYDPRINTF ((stderr, "Stack size increased to %lu\n",
		  (unsigned long int) yystacksize));

      if (yyss + yystacksize - 1 <= yyssp)
	YYABORT;
    }

  YYDPRINTF ((stderr, "Entering state %d\n", yystate));

  goto yybackup;

/*-----------.
| yybackup.  |
`-----------*/
yybackup:

/* Do appropriate processing given the current state.  */
/* Read a lookahead token if we need one and don't already have one.  */
/* yyresume: */

  /* First try to decide what to do without reference to lookahead token.  */

  yyn = yypact[yystate];
  if (yyn == YYPACT_NINF)
    goto yydefault;

  /* Not known => get a lookahead token if don't already have one.  */

  /* YYCHAR is either YYEMPTY or YYEOF or a valid lookahead symbol.  */
  if (yychar == YYEMPTY)
    {
      YYDPRINTF ((stderr, "Reading a token: "));
      yychar = YYLEX;
    }

  if (yychar <= YYEOF)
    {
      yychar = yytoken = YYEOF;
      YYDPRINTF ((stderr, "Now at end of input.\n"));
    }
  else
    {
      yytoken = YYTRANSLATE (yychar);
      YYDSYMPRINTF ("Next token is", yytoken, &yylval, &yylloc);
    }

  /* If the proper action on seeing token YYTOKEN is to reduce or to
     detect an error, take that action.  */
  yyn += yytoken;
  if (yyn < 0 || YYLAST < yyn || yycheck[yyn] != yytoken)
    goto yydefault;
  yyn = yytable[yyn];
  if (yyn <= 0)
    {
      if (yyn == 0 || yyn == YYTABLE_NINF)
	goto yyerrlab;
      yyn = -yyn;
      goto yyreduce;
    }

  if (yyn == YYFINAL)
    YYACCEPT;

  /* Shift the lookahead token.  */
  YYDPRINTF ((stderr, "Shifting token %s, ", yytname[yytoken]));

  /* Discard the token being shifted unless it is eof.  */
  if (yychar != YYEOF)
    yychar = YYEMPTY;

  *++yyvsp = yylval;


  /* Count tokens shifted since error; after three, turn off error
     status.  */
  if (yyerrstatus)
    yyerrstatus--;

  yystate = yyn;
  goto yynewstate;


/*-----------------------------------------------------------.
| yydefault -- do the default action for the current state.  |
`-----------------------------------------------------------*/
yydefault:
  yyn = yydefact[yystate];
  if (yyn == 0)
    goto yyerrlab;
  goto yyreduce;


/*-----------------------------.
| yyreduce -- Do a reduction.  |
`-----------------------------*/
yyreduce:
  /* yyn is the number of a rule to reduce with.  */
  yylen = yyr2[yyn];

  /* If YYLEN is nonzero, implement the default value of the action:
     `$$ = $1'.

     Otherwise, the following line sets YYVAL to garbage.
     This behavior is undocumented and Bison
     users should not rely upon it.  Assigning to YYVAL
     unconditionally makes the parser a bit smaller, and it avoids a
     GCC warning that YYVAL may be used uninitialized.  */
  yyval = yyvsp[1-yylen];


  YY_REDUCE_PRINT (yyn);
  switch (yyn)
    {
        case 2:
#line 69 "STGrammar.y"
    { 
                                [COMPILER compileMethod:nil]; 
                            ;}
    break;

  case 3:
#line 74 "STGrammar.y"
    {
                                [COMPILER compileMethod:yyvsp[0]];
                            ;}
    break;

  case 4:
#line 80 "STGrammar.y"
    {
                                [COMPILER compileMethod:yyvsp[0]];
                            ;}
    break;

  case 5:
#line 86 "STGrammar.y"
    {
                                [COMPILER beginScript];
                            ;}
    break;

  case 7:
#line 94 "STGrammar.y"
    {
                                yyval =  [STCMethod methodWithPattern:nil
                                /**/                    statements:yyvsp[0]];
                            ;}
    break;

  case 8:
#line 99 "STGrammar.y"
    {
                                [yyvsp[0] setTemporaries:yyvsp[-1]];
                                yyval =  [STCMethod methodWithPattern:nil
                                /**/                    statements:yyvsp[0]];
                            ;}
    break;

  case 9:
#line 108 "STGrammar.y"
    {
                                [COMPILER setReceiverVariables:yyvsp[0]];
                            ;}
    break;

  case 12:
#line 117 "STGrammar.y"
    {
                                [COMPILER compileMethod:yyvsp[0]];
                            ;}
    break;

  case 13:
#line 121 "STGrammar.y"
    {
                                [COMPILER compileMethod:yyvsp[0]];
                            ;}
    break;

  case 14:
#line 127 "STGrammar.y"
    {
                                yyval =  [STCMethod methodWithPattern:yyvsp[-1]
                                /**/                    statements:yyvsp[0]];
                            ;}
    break;

  case 15:
#line 132 "STGrammar.y"
    {
                                [yyvsp[0] setTemporaries:yyvsp[-1]];
                                yyval =  [STCMethod methodWithPattern:yyvsp[-2]
                                /**/                    statements:yyvsp[0]];
                            ;}
    break;

  case 16:
#line 141 "STGrammar.y"
    {
                                yyval = [STCMessage message];
                                [yyval addKeyword:yyvsp[0] object:nil];
                            ;}
    break;

  case 17:
#line 146 "STGrammar.y"
    {
                                yyval = [STCMessage message];
                                [yyval addKeyword:yyvsp[-1] object:yyvsp[0]];
                            ;}
    break;

  case 19:
#line 154 "STGrammar.y"
    {
                                yyval = [STCMessage message];
                                [yyval addKeyword:yyvsp[-1] object:yyvsp[0]];
                            ;}
    break;

  case 20:
#line 159 "STGrammar.y"
    {
                                [yyvsp[-2] addKeyword:yyvsp[-1] object:yyvsp[0]];
                                yyval = yyvsp[-2];
                            ;}
    break;

  case 21:
#line 166 "STGrammar.y"
    { yyval = yyvsp[-1]; ;}
    break;

  case 22:
#line 170 "STGrammar.y"
    { 
                                yyval = [NSMutableArray array];
                                [yyval addObject:yyvsp[0]]; 
                            ;}
    break;

  case 23:
#line 175 "STGrammar.y"
    { 
                                yyval = yyvsp[-1]; 
                                [yyval addObject:yyvsp[0]]; 
                            ;}
    break;

  case 24:
#line 182 "STGrammar.y"
    {
                                yyval = [STCStatements statements];
                            ;}
    break;

  case 25:
#line 186 "STGrammar.y"
    {
                                yyval = yyvsp[-1];
                            ;}
    break;

  case 26:
#line 190 "STGrammar.y"
    {
                                yyval = yyvsp[-1];
                                [yyval setTemporaries:yyvsp[-3]];
                            ;}
    break;

  case 27:
#line 196 "STGrammar.y"
    { 
                                yyval = [NSMutableArray array];
                                [yyval addObject:yyvsp[0]]; 
                            ;}
    break;

  case 28:
#line 201 "STGrammar.y"
    { 
                                yyval = yyvsp[-2]; 
                                [yyval addObject:yyvsp[0]]; 
                            ;}
    break;

  case 29:
#line 208 "STGrammar.y"
    { 
                                yyval = [STCStatements statements];
                                [yyval setReturnExpression:yyvsp[0]];
                            ;}
    break;

  case 30:
#line 213 "STGrammar.y"
    { 
                                yyval = [STCStatements statements];
                                [yyval setExpressions:yyvsp[0]];
                            ;}
    break;

  case 31:
#line 219 "STGrammar.y"
    { 
                                yyval = [STCStatements statements];
                                [yyval setExpressions:yyvsp[-1]];
                            ;}
    break;

  case 32:
#line 224 "STGrammar.y"
    { 
                                yyval = [STCStatements statements];
                                [yyval setReturnExpression:yyvsp[0]];
                                [yyval setExpressions:yyvsp[-3]];
                            ;}
    break;

  case 33:
#line 232 "STGrammar.y"
    { 
                                yyval = [NSMutableArray array];
                                [yyval addObject:yyvsp[0]];
                            ;}
    break;

  case 34:
#line 238 "STGrammar.y"
    {   
                                yyval = yyvsp[-2]; 
                                [yyval addObject:yyvsp[0]]; 
                            ;}
    break;

  case 35:
#line 244 "STGrammar.y"
    { 
                                yyval = [STCExpression 
                                /**/          primaryExpressionWithObject:yyvsp[0]];
                            ;}
    break;

  case 36:
#line 249 "STGrammar.y"
    { 
                                yyval = [STCExpression 
                                /**/          primaryExpressionWithObject:yyvsp[0]];
                                [yyval setAssignments:yyvsp[-1]];
                            ;}
    break;

  case 38:
#line 256 "STGrammar.y"
    { 
                                yyval = yyvsp[0];
                                [yyval setAssignments:yyvsp[-1]];
                            ;}
    break;

  case 40:
#line 262 "STGrammar.y"
    { 
                                yyval = yyvsp[0];
                                [yyval setAssignments:yyvsp[-1]];
                            ;}
    break;

  case 41:
#line 268 "STGrammar.y"
    { 
                                yyval = [NSMutableArray array];
                                [yyval addObject:yyvsp[0]];
                            ;}
    break;

  case 42:
#line 273 "STGrammar.y"
    { 
                                yyval = yyvsp[-1]; 
                                [yyval addObject:yyvsp[0]]; 
                            ;}
    break;

  case 43:
#line 280 "STGrammar.y"
    { yyval = yyvsp[-1];;}
    break;

  case 44:
#line 283 "STGrammar.y"
    { 
                                /* FIXME: check if this is this OK */
                                [yyval setCascade:yyvsp[0]]; 
                            ;}
    break;

  case 45:
#line 289 "STGrammar.y"
    {
                                yyval = [NSMutableArray array];
                                [yyval addObject:yyvsp[0]]; 
                            ;}
    break;

  case 46:
#line 294 "STGrammar.y"
    { 
                                yyval = yyvsp[-2]; 
                                [yyval addObject:yyvsp[0]];
                            ;}
    break;

  case 47:
#line 300 "STGrammar.y"
    { 
                                yyval = [STCMessage message];
                                [yyval addKeyword:yyvsp[0] object:nil];
                            ;}
    break;

  case 48:
#line 305 "STGrammar.y"
    { 
                                yyval = [STCMessage message];
                                [yyval addKeyword:yyvsp[-1] object:yyvsp[0]];
                            ;}
    break;

  case 53:
#line 317 "STGrammar.y"
    { 
                                STCMessage *message = [STCMessage message];
                                [message addKeyword:yyvsp[0] object:nil];
                                yyval = [STCExpression 
                                /**/        messageExpressionWithTarget:yyvsp[-1]
                                /**/        message:message];
                            ;}
    break;

  case 54:
#line 326 "STGrammar.y"
    { 
                                STCMessage *message = [STCMessage message];
                                [message addKeyword:yyvsp[-1] object:yyvsp[0]];
                                yyval = [STCExpression 
                                /**/        messageExpressionWithTarget:yyvsp[-2]
                                /**/        message:message];
                            ;}
    break;

  case 55:
#line 335 "STGrammar.y"
    {
                                yyval = [STCExpression 
                                /**/        messageExpressionWithTarget:yyvsp[-1]
                                /**/        message:yyvsp[0]];
                            ;}
    break;

  case 56:
#line 342 "STGrammar.y"
    { 
                                yyval = [STCMessage message];
                                [yyval addKeyword:yyvsp[-1] object:yyvsp[0]];
                            ;}
    break;

  case 57:
#line 347 "STGrammar.y"
    { 
                                yyval = yyvsp[-2];
                                [yyval addKeyword:yyvsp[-1] object:yyvsp[0]];
                            ;}
    break;

  case 62:
#line 359 "STGrammar.y"
    {
                                yyval = [STCPrimary primaryWithVariable:yyvsp[0]];
                            ;}
    break;

  case 63:
#line 363 "STGrammar.y"
    {
                                yyval = [STCPrimary primaryWithLiteral:yyvsp[0]];
                            ;}
    break;

  case 64:
#line 367 "STGrammar.y"
    {
                                yyval = [STCPrimary primaryWithBlock:yyvsp[0]];
                            ;}
    break;

  case 65:
#line 371 "STGrammar.y"
    {
                                yyval = [STCPrimary primaryWithExpression:yyvsp[-1]];
                            ;}
    break;

  case 70:
#line 385 "STGrammar.y"
    { yyval = [COMPILER createIntNumberLiteralFrom:yyvsp[0]]; ;}
    break;

  case 71:
#line 387 "STGrammar.y"
    { yyval = [COMPILER createRealNumberLiteralFrom:yyvsp[0]]; ;}
    break;

  case 72:
#line 389 "STGrammar.y"
    { yyval = [COMPILER createSymbolLiteralFrom:yyvsp[0]]; ;}
    break;

  case 73:
#line 391 "STGrammar.y"
    { yyval = [COMPILER createStringLiteralFrom:yyvsp[0]]; ;}
    break;

  case 74:
#line 393 "STGrammar.y"
    { yyval = [COMPILER createCharacterLiteralFrom:yyvsp[0]]; ;}
    break;

  case 75:
#line 395 "STGrammar.y"
    { yyval = [COMPILER createArrayLiteralFrom:yyvsp[-1]]; ;}
    break;

  case 76:
#line 397 "STGrammar.y"
    { yyval = [NSMutableArray array]; ;}
    break;

  case 77:
#line 398 "STGrammar.y"
    { yyval = [NSMutableArray array]; 
                                   [yyval addObject:yyvsp[0]]; ;}
    break;

  case 78:
#line 400 "STGrammar.y"
    { yyval = [NSMutableArray array];
                                   [yyval addObject:yyvsp[0]]; ;}
    break;

  case 79:
#line 402 "STGrammar.y"
    { yyval = yyvsp[-1]; [yyval addObject:yyvsp[0]]; ;}
    break;

  case 80:
#line 403 "STGrammar.y"
    { yyval = yyvsp[-1]; [yyval addObject:yyvsp[0]]; ;}
    break;

  case 81:
#line 406 "STGrammar.y"
    { yyval = [COMPILER createSymbolLiteralFrom:yyvsp[0]]; ;}
    break;

  case 82:
#line 408 "STGrammar.y"
    { yyval = [COMPILER createSymbolLiteralFrom:yyvsp[0]]; ;}
    break;

  case 83:
#line 410 "STGrammar.y"
    { yyval = [COMPILER createSymbolLiteralFrom:yyvsp[0]]; ;}
    break;


    }

/* Line 1010 of yacc.c.  */
#line 1661 "STGrammar.m"

  yyvsp -= yylen;
  yyssp -= yylen;


  YY_STACK_PRINT (yyss, yyssp);

  *++yyvsp = yyval;


  /* Now `shift' the result of the reduction.  Determine what state
     that goes to, based on the state we popped back to and the rule
     number reduced by.  */

  yyn = yyr1[yyn];

  yystate = yypgoto[yyn - YYNTOKENS] + *yyssp;
  if (0 <= yystate && yystate <= YYLAST && yycheck[yystate] == *yyssp)
    yystate = yytable[yystate];
  else
    yystate = yydefgoto[yyn - YYNTOKENS];

  goto yynewstate;


/*------------------------------------.
| yyerrlab -- here on detecting error |
`------------------------------------*/
yyerrlab:
  /* If not already recovering from an error, report this error.  */
  if (!yyerrstatus)
    {
      ++yynerrs;
#if YYERROR_VERBOSE
      yyn = yypact[yystate];

      if (YYPACT_NINF < yyn && yyn < YYLAST)
	{
	  YYSIZE_T yysize = 0;
	  int yytype = YYTRANSLATE (yychar);
	  const char* yyprefix;
	  char *yymsg;
	  int yyx;

	  /* Start YYX at -YYN if negative to avoid negative indexes in
	     YYCHECK.  */
	  int yyxbegin = yyn < 0 ? -yyn : 0;

	  /* Stay within bounds of both yycheck and yytname.  */
	  int yychecklim = YYLAST - yyn;
	  int yyxend = yychecklim < YYNTOKENS ? yychecklim : YYNTOKENS;
	  int yycount = 0;

	  yyprefix = ", expecting ";
	  for (yyx = yyxbegin; yyx < yyxend; ++yyx)
	    if (yycheck[yyx + yyn] == yyx && yyx != YYTERROR)
	      {
		yysize += yystrlen (yyprefix) + yystrlen (yytname [yyx]);
		yycount += 1;
		if (yycount == 5)
		  {
		    yysize = 0;
		    break;
		  }
	      }
	  yysize += (sizeof ("syntax error, unexpected ")
		     + yystrlen (yytname[yytype]));
	  yymsg = (char *) YYSTACK_ALLOC (yysize);
	  if (yymsg != 0)
	    {
	      char *yyp = yystpcpy (yymsg, "syntax error, unexpected ");
	      yyp = yystpcpy (yyp, yytname[yytype]);

	      if (yycount < 5)
		{
		  yyprefix = ", expecting ";
		  for (yyx = yyxbegin; yyx < yyxend; ++yyx)
		    if (yycheck[yyx + yyn] == yyx && yyx != YYTERROR)
		      {
			yyp = yystpcpy (yyp, yyprefix);
			yyp = yystpcpy (yyp, yytname[yyx]);
			yyprefix = " or ";
		      }
		}
	      yyerror (yymsg);
	      YYSTACK_FREE (yymsg);
	    }
	  else
	    yyerror ("syntax error; also virtual memory exhausted");
	}
      else
#endif /* YYERROR_VERBOSE */
	yyerror ("syntax error");
    }



  if (yyerrstatus == 3)
    {
      /* If just tried and failed to reuse lookahead token after an
	 error, discard it.  */

      if (yychar <= YYEOF)
        {
          /* If at end of input, pop the error token,
	     then the rest of the stack, then return failure.  */
	  if (yychar == YYEOF)
	     for (;;)
	       {
		 YYPOPSTACK;
		 if (yyssp == yyss)
		   YYABORT;
		 YYDSYMPRINTF ("Error: popping", yystos[*yyssp], yyvsp, yylsp);
		 yydestruct (yystos[*yyssp], yyvsp);
	       }
        }
      else
	{
	  YYDSYMPRINTF ("Error: discarding", yytoken, &yylval, &yylloc);
	  yydestruct (yytoken, &yylval);
	  yychar = YYEMPTY;

	}
    }

  /* Else will try to reuse lookahead token after shifting the error
     token.  */
  goto yyerrlab1;


/*---------------------------------------------------.
| yyerrorlab -- error raised explicitly by YYERROR.  |
`---------------------------------------------------*/
yyerrorlab:

#ifdef __GNUC__
  /* Pacify GCC when the user code never invokes YYERROR and the label
     yyerrorlab therefore never appears in user code.  */
  if (0)
     goto yyerrorlab;
#endif

  yyvsp -= yylen;
  yyssp -= yylen;
  yystate = *yyssp;
  goto yyerrlab1;


/*-------------------------------------------------------------.
| yyerrlab1 -- common code for both syntax error and YYERROR.  |
`-------------------------------------------------------------*/
yyerrlab1:
  yyerrstatus = 3;	/* Each real token shifted decrements this.  */

  for (;;)
    {
      yyn = yypact[yystate];
      if (yyn != YYPACT_NINF)
	{
	  yyn += YYTERROR;
	  if (0 <= yyn && yyn <= YYLAST && yycheck[yyn] == YYTERROR)
	    {
	      yyn = yytable[yyn];
	      if (0 < yyn)
		break;
	    }
	}

      /* Pop the current state because it cannot handle the error token.  */
      if (yyssp == yyss)
	YYABORT;

      YYDSYMPRINTF ("Error: popping", yystos[*yyssp], yyvsp, yylsp);
      yydestruct (yystos[yystate], yyvsp);
      YYPOPSTACK;
      yystate = *yyssp;
      YY_STACK_PRINT (yyss, yyssp);
    }

  if (yyn == YYFINAL)
    YYACCEPT;

  YYDPRINTF ((stderr, "Shifting error token, "));

  *++yyvsp = yylval;


  yystate = yyn;
  goto yynewstate;


/*-------------------------------------.
| yyacceptlab -- YYACCEPT comes here.  |
`-------------------------------------*/
yyacceptlab:
  yyresult = 0;
  goto yyreturn;

/*-----------------------------------.
| yyabortlab -- YYABORT comes here.  |
`-----------------------------------*/
yyabortlab:
  yyresult = 1;
  goto yyreturn;

#ifndef yyoverflow
/*----------------------------------------------.
| yyoverflowlab -- parser overflow comes here.  |
`----------------------------------------------*/
yyoverflowlab:
  yyerror ("parser stack overflow");
  yyresult = 2;
  /* Fall through.  */
#endif

yyreturn:
#ifndef yyoverflow
  if (yyss != yyssa)
    YYSTACK_FREE (yyss);
#endif
  return yyresult;
}


#line 412 "STGrammar.y"


int STCerror(const char *str)
{
    [NSException raise:STCompilerSyntaxException
                 format:@"Unknown parse error (%s)", str];
    return 0;
}



/* 
 * Lexer
 * --------------------------------------------------------------------------
 */

int STClex (YYSTYPE *lvalp, void *context)
{
    STTokenType tokenType = [READER nextToken];

    if(tokenType == STEndTokenType)
    {
        return 0;
    }

    *lvalp = [READER tokenString];

    switch(tokenType)
    {
    case STBarTokenType:            return TK_BAR;
    case STReturnTokenType:         return TK_RETURN;
    case STColonTokenType:          return TK_COLON;
    case STSemicolonTokenType:      return TK_SEMICOLON;
    case STDotTokenType:            return TK_DOT;
    case STLParenTokenType:         return TK_LPAREN;
    case STRParenTokenType:         return TK_RPAREN;
    case STBlockOpenTokenType:      return TK_BLOCK_OPEN;
    case STBlockCloseTokenType:     return TK_BLOCK_CLOSE;
    case STArrayOpenTokenType:      return TK_ARRAY_OPEN;
    case STAssignTokenType:         return TK_ASSIGNMENT;
    case STIdentifierTokenType:     return TK_IDENTIFIER;
    case STKeywordTokenType:        return TK_KEYWORD;
    case STBinarySelectorTokenType: return TK_BINARY_SELECTOR;
    case STSymbolTokenType:         return TK_SYMBOL;
    case STStringTokenType:         return TK_STRING;
    case STCharacterTokenType:      return TK_CHARACTER;
    case STIntNumberTokenType:         return TK_INTNUMBER;
    case STRealNumberTokenType:         return TK_REALNUMBER;
    case STSeparatorTokenType:      return TK_SEPARATOR;

    case STEndTokenType:            return 0;

    case STSharpTokenType:
    case STInvalidTokenType:
    case STErrorTokenType:
                                    return 1;
    }

    return 1;   
}


