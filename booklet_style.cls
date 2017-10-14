% !TEX root = thesis_booklet_BB.tex
\ProvidesClass{booklet_style}
\LoadClass[8pt,a5paper,twoside,openright]{article}
%\usepackage[utf8x]{inputenc}
%\usepackage{ucs}
% \usepackage{fullpage}
\usepackage[includeheadfoot,inner=2cm,outer=2cm,top=2cm,bottom=2cm]{geometry}
\usepackage{amsmath}
\usepackage{amsfonts}
\usepackage{amssymb}
\usepackage{makeidx}
\usepackage{graphicx}
\usepackage[margin=11pt,font=scriptsize,labelfont=bf]{caption} % for improved layout of figure captions 
\usepackage{subcaption}
\usepackage{verbatim}
\usepackage{booktabs}
\usepackage{upgreek}
\usepackage{siunitx}
%\usepackage{fancyhdr} % for better header layout

\usepackage[ plainpages = false, pdfpagelabels,
                 %pdftex,
                 %pdfpagelayout = useoutlines,
                 bookmarks,
                 bookmarksopen = true,
                 bookmarksnumbered = true,
                 breaklinks = true,
                 linktocpage,
                 %pagebackref,
                 colorlinks = true,  % was true
                 linkcolor = black,	% blue
                 urlcolor  = black,	% blue
                 citecolor = black,	%red
                 anchorcolor = black,	% green
                 hyperindex = true,
                 hyperfigures]{hyperref} 

\usepackage{setspace}
\onehalfspacing


%\renewcommand{\bibname}{Refferences}

%\pagestyle{headings}
%\pagestyle{fancy}
%renewcommand{\chaptermark}[1]{\markboth{\MakeUppercase{\thechapter. #1 }}{}}
%\renewcommand{\sectionmark}[1]{\markright{\thesection\ #1}}
%\fancyhf{}
%\fancyhead[R]{\bfseries\rightmark}
%\fancyhead[L]{\bfseries\leftmark}
%\fancyfoot[C]{\thepage}

%\setlength{textwidth}{15.2cm}



\def\degreedate#1{\gdef\@degreedate{#1}}
% The full (unabbreviated) name of the degree
\def\degree#1{\gdef\@degree{#1}}
% The name of your college or department(eg. Trinity, Pembroke, Maths, Physics)
\def\collegeordept#1{\gdef\@collegeordept{#1}}
% The name of your University
\def\university#1{\gdef\@university{#1}}
% The name of your supervisor
\def\supervisor#1{\gdef\@supervisor{#1}}
\def\lab#1{\gdef\@lab{#1}}
% Defining the crest
\def\ppke#1{\gdef\@ppke{#1}}
\def\embl#1{\gdef\@embl{#1}}


\renewcommand{\maketitle}{
    %\renewcommand{\footnotesize}{\small}
    %\renewcommand{\footnoterule}{\relax}
 
  \thispagestyle{empty}
%  \null\vfill
  \begin{center}
  
  	%\vspace*{15mm}
    {\LARGE {\textbf {\@title}} \par}
	\vspace*{10mm}
    {{\Large \@author} \par}

	\vspace*{10mm}
    \@ppke \par
	\vspace*{0.5ex}
    \@university \par
	\vspace*{0.5ex}
    \@collegeordept \par
		
	\vspace*{10mm}
    \@embl \par
	\vspace*{0.5ex}
    \@lab \par
	\vspace*{0.5ex}
    Supervisors: \@supervisor \par
	\vspace*{10mm}
    \@degreedate

  \end{center}
  
}


\newenvironment{nyilatkozat}
{\newpage
\thispagestyle{empty}
\begin{center}
\vspace*{1.5cm}
{\Large \bfseries Nyilatkozat}
\end{center}
\vspace{0.5cm}
\begin{quote}}
{\end{quote}}


\newenvironment{absztrakt}
{\newpage
\thispagestyle{empty}
\begin{center}
\vspace*{1.5cm}
{\Large \bfseries Tartalmi kivonat}
\end{center}
\vspace{0.5cm}
\begin{quote}}
{\end{quote}}

\renewenvironment{abstract}
{
\newpage
\thispagestyle{empty}
\begin{center}
\vspace*{1.5cm}
{\Large \bfseries Abstract}
\end{center}
\vspace{0.5cm}
\begin{quote}}
{\end{quote}}

\newenvironment{acknowledgements}
{\newpage
\thispagestyle{empty}
\begin{center}
\vspace*{1.5cm}
{\Large \bfseries Acknowledgements}
\end{center}
\vspace{0.5cm}
\begin{quote}}
{\end{quote}}

\setcounter{secnumdepth}{2}

\setcounter{tocdepth}{1}


%\addtolength{\textwidth}{-1cm}
%\addtolength{\oddsidemargin}{1cm}
%\addtolength{\textheight}{-0.5cm}
%\addtolength{\topmargin}{0.5cm}
%\setlength{\headwidth}{\textwidth}
%\usepackage{showframe}