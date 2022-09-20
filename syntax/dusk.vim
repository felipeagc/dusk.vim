if exists("b:current_syntax")
  finish
endif

let b:current_syntax = "dusk"

" Match language specific keywords
syn keyword duskKeyword
			\ if else while switch
			\ type struct import
			\ return discard continue break
			\ fn var const

syn keyword duskBuiltin
			\ @Sampler
			\ @Image1D @Image2D @Image2DArray @Image3D @ImageCube @ImageCubeArray
			\ @Image1DSampler @Image2DSampler @Image2DArraySampler @Image3DSampler @ImageCubeSampler @ImageCubeArraySampler
			\ @sample
			\ @distance @length @normalize @cross @sqrt @inverseSqrt @log @log2 @exp @exp2
			\ @determinant @inverse 
			\ @reflect @refract
			\ @modf @min @max @clamp @mix @step @smoothstep @fma
			\ @asin @acos @atan @sinh @cosh @tanh @asinh @acosh @atanh
			\ @atan2 @pow 
			\ @floor @ceil @fract @radians @degrees @sin @cos @tan

" syn keyword duskKeyword var nextgroup=duskFuncName skipwhite skipempty

syn keyword duskType
			\ void bool
			\ double double2 double3 double4
			\ float float2 float3 float4
			\ int int2 int3 int4
			\ uint uint2 uint3 uint4
			\ float2x2 float2x3 float3x2 float3x3 float4x3 float3x4 float4x4
			\ int2x2 int2x3 int3x2 int3x3 int4x3 int3x4 int4x4
			\ uint2x2 uint2x3 uint3x2 uint3x3 uint4x3 uint3x4 uint4x4

" syn keyword duskNumber
" 			\ null

syn keyword duskBoolean true false

syn match duskComment "\v\/\/.*$"
syn region duskComment start="/\*" end="\*/" fold

syn match duskNumber display "\<[0-9]\+\%(.[0-9]\+\)\=\%([eE][+-]\?[0-9]\+\)\="
syn match duskNumber display "\<0x[a-fA-F0-9]\+\%([a-fA-F0-9]\+\%([pP][+-]\?[0-9]\+\)\?\)\="
syn match duskNumber display "\<0o[0-7]\+"
syn match duskNumber display "\<0b[01]\+\%(.[01]\+\%([eE][+-]\?[0-9]\+\)\?\)\="

syn match duskEscapeError display contained /\\./
syn match duskEscape      display contained /\\\([nrt\\'"]\|x\x\{2}\)/

syn region duskString start=+c\?"+ skip=+\\\\\|\\"+ end=+"+ oneline contains=duskEscape,duskEscapeError,@Spell

syn match duskCharacter /'\([^\\]\|\\\(.\)\)'/ contains=duskEscape,duskEscapeError

syn keyword duskTodo contained TODO

syn region duskBlock start="{" end="}" transparent fold

" syn match duskFuncName "\%([^[:cntrl:][:space:][:punct:][:digit:]]\|_\)\%([^[:cntrl:][:punct:][:space:]]\|_\)*" display contained
" syn match duskFuncCall "\w\(\w\)*("he=e-1,me=e-1

syn region duskAttribute start="#!\?\[" end="\]" contains=@duskAttributeContents
syn cluster duskAttributeContents contains=duskString

hi def link duskComment Comment
hi def link duskString String
hi def link duskCharacter Character
hi def link duskKeyword Keyword
" hi def link duskKeyword StorageClass
hi def link duskBuiltin Identifier
hi def link duskStorageClass Type
hi def link duskBoolean Boolean
hi def link duskNumber Number
hi def link duskType Type
hi def link duskEscape Special
hi def link duskEscapeError Error
hi def link duskTodo Todo
hi def link duskAttribute PreProc
hi def link duskFuncName Function
hi def link duskFuncCall Function
