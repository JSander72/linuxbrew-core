class Skylighting < Formula
  desc "Flexible syntax highlighter using KDE XML syntax descriptions"
  homepage "https://github.com/jgm/skylighting"
  url "https://github.com/jgm/skylighting/archive/0.12.tar.gz"
  sha256 "0bab2c013a127d0be21fe8375308c0a910ddc6439560d063acd6dad8ed6a706a"
  license "GPL-2.0-or-later"
  head "https://github.com/jgm/skylighting.git", branch: "master"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "f49b170b752ec94d5e5f22979d974dc9007092f762e725a5b3abe422a791c534"
    sha256 cellar: :any_skip_relocation, big_sur:       "4a5bbd597cbe1dcd6c087d5509186f7fc99267a67fbcc961ccfc6b833128b1c0"
    sha256 cellar: :any_skip_relocation, catalina:      "7fc0821708c96c312693534de4e6c05f4ca95908b49529453c6e535e29da5966"
    sha256 cellar: :any_skip_relocation, mojave:        "3aa1b87c519096b54bd6d214578414a303f24cafc3786cf8dbaa125b5f6594b7"
  end

  depends_on "cabal-install" => :build
  depends_on "ghc" => :build

  def install
    system "cabal", "v2-update"

    # moving this file aside during the first package's compilation avoids
    # spurious errors about undeclared autogenerated modules
    mv buildpath/"skylighting/skylighting.cabal", buildpath/"skylighting.cabal.temp-loc"
    system "cabal", "v2-install", buildpath/"skylighting-core", "-fexecutable", *std_cabal_v2_args
    mv buildpath/"skylighting.cabal.temp-loc", buildpath/"skylighting/skylighting.cabal"

    cd "skylighting" do
      system bin/"skylighting-extract", buildpath/"skylighting-core/xml"
    end
    system "cabal", "v2-install", buildpath/"skylighting", "-fexecutable", *std_cabal_v2_args
  end

  test do
    (testpath/"Test.java").write <<~EOF
      import java.util.*;

      public class Test {
          public static void main(String[] args) throws Exception {
              final ArrayDeque<String> argDeque = new ArrayDeque<>(Arrays.asList(args));
              for (arg in argDeque) {
                  System.out.println(arg);
                  if (arg.equals("foo"))
                      throw new NoSuchElementException();
              }
          }
      }
    EOF
    expected_out = <<~EOF
      \\documentclass{article}
      \\usepackage[margin=1in]{geometry}
      \\usepackage{color}
      \\usepackage{fancyvrb}
      \\newcommand{\\VerbBar}{|}
      \\newcommand{\\VERB}{\\Verb[commandchars=\\\\\\{\\}]}
      \\DefineVerbatimEnvironment{Highlighting}{Verbatim}{commandchars=\\\\\\{\\}}
      % Add ',fontsize=\\small' for more characters per line
      \\usepackage{framed}
      \\definecolor{shadecolor}{RGB}{255,255,255}
      \\newenvironment{Shaded}{\\begin{snugshade}}{\\end{snugshade}}
      \\newcommand{\\AlertTok}[1]{\\textcolor[rgb]{0.75,0.01,0.01}{\\textbf{\\colorbox[rgb]{0.97,0.90,0.90}{#1}}}}
      \\newcommand{\\AnnotationTok}[1]{\\textcolor[rgb]{0.79,0.38,0.79}{#1}}
      \\newcommand{\\AttributeTok}[1]{\\textcolor[rgb]{0.00,0.34,0.68}{#1}}
      \\newcommand{\\BaseNTok}[1]{\\textcolor[rgb]{0.69,0.50,0.00}{#1}}
      \\newcommand{\\BuiltInTok}[1]{\\textcolor[rgb]{0.39,0.29,0.61}{\\textbf{#1}}}
      \\newcommand{\\CharTok}[1]{\\textcolor[rgb]{0.57,0.30,0.62}{#1}}
      \\newcommand{\\CommentTok}[1]{\\textcolor[rgb]{0.54,0.53,0.53}{#1}}
      \\newcommand{\\CommentVarTok}[1]{\\textcolor[rgb]{0.00,0.58,1.00}{#1}}
      \\newcommand{\\ConstantTok}[1]{\\textcolor[rgb]{0.67,0.33,0.00}{#1}}
      \\newcommand{\\ControlFlowTok}[1]{\\textcolor[rgb]{0.12,0.11,0.11}{\\textbf{#1}}}
      \\newcommand{\\DataTypeTok}[1]{\\textcolor[rgb]{0.00,0.34,0.68}{#1}}
      \\newcommand{\\DecValTok}[1]{\\textcolor[rgb]{0.69,0.50,0.00}{#1}}
      \\newcommand{\\DocumentationTok}[1]{\\textcolor[rgb]{0.38,0.47,0.50}{#1}}
      \\newcommand{\\ErrorTok}[1]{\\textcolor[rgb]{0.75,0.01,0.01}{\\underline{#1}}}
      \\newcommand{\\ExtensionTok}[1]{\\textcolor[rgb]{0.00,0.58,1.00}{\\textbf{#1}}}
      \\newcommand{\\FloatTok}[1]{\\textcolor[rgb]{0.69,0.50,0.00}{#1}}
      \\newcommand{\\FunctionTok}[1]{\\textcolor[rgb]{0.39,0.29,0.61}{#1}}
      \\newcommand{\\ImportTok}[1]{\\textcolor[rgb]{1.00,0.33,0.00}{#1}}
      \\newcommand{\\InformationTok}[1]{\\textcolor[rgb]{0.69,0.50,0.00}{#1}}
      \\newcommand{\\KeywordTok}[1]{\\textcolor[rgb]{0.12,0.11,0.11}{\\textbf{#1}}}
      \\newcommand{\\NormalTok}[1]{\\textcolor[rgb]{0.12,0.11,0.11}{#1}}
      \\newcommand{\\OperatorTok}[1]{\\textcolor[rgb]{0.12,0.11,0.11}{#1}}
      \\newcommand{\\OtherTok}[1]{\\textcolor[rgb]{0.00,0.43,0.16}{#1}}
      \\newcommand{\\PreprocessorTok}[1]{\\textcolor[rgb]{0.00,0.43,0.16}{#1}}
      \\newcommand{\\RegionMarkerTok}[1]{\\textcolor[rgb]{0.00,0.34,0.68}{\\colorbox[rgb]{0.88,0.91,0.97}{#1}}}
      \\newcommand{\\SpecialCharTok}[1]{\\textcolor[rgb]{0.24,0.68,0.91}{#1}}
      \\newcommand{\\SpecialStringTok}[1]{\\textcolor[rgb]{1.00,0.33,0.00}{#1}}
      \\newcommand{\\StringTok}[1]{\\textcolor[rgb]{0.75,0.01,0.01}{#1}}
      \\newcommand{\\VariableTok}[1]{\\textcolor[rgb]{0.00,0.34,0.68}{#1}}
      \\newcommand{\\VerbatimStringTok}[1]{\\textcolor[rgb]{0.75,0.01,0.01}{#1}}
      \\newcommand{\\WarningTok}[1]{\\textcolor[rgb]{0.75,0.01,0.01}{#1}}
      \\title{#{testpath/"Test.java"}}

      \\begin{document}
      \\maketitle
      \\begin{Shaded}
      \\begin{Highlighting}[]
      \\KeywordTok{import} \\ImportTok{java}\\OperatorTok{.}\\ImportTok{util}\\OperatorTok{.*;}

      \\KeywordTok{public} \\KeywordTok{class}\\NormalTok{ Test }\\OperatorTok{\\{}
          \\KeywordTok{public} \\DataTypeTok{static} \\DataTypeTok{void} \\FunctionTok{main}\\OperatorTok{(}\\BuiltInTok{String}\\OperatorTok{[]}\\NormalTok{ args}\\OperatorTok{)} \\KeywordTok{throws} \\BuiltInTok{Exception} \\OperatorTok{\\{}
              \\DataTypeTok{final} \\BuiltInTok{ArrayDeque}\\OperatorTok{\\textless{}}\\BuiltInTok{String}\\OperatorTok{\\textgreater{}}\\NormalTok{ argDeque }\\OperatorTok{=} \\KeywordTok{new} \\BuiltInTok{ArrayDeque}\\OperatorTok{\\textless{}\\textgreater{}(}\\BuiltInTok{Arrays}\\OperatorTok{.}\\FunctionTok{asList}\\OperatorTok{(}\\NormalTok{args}\\OperatorTok{));}
              \\ControlFlowTok{for} \\OperatorTok{(}\\NormalTok{arg in argDeque}\\OperatorTok{)} \\OperatorTok{\\{}
                  \\BuiltInTok{System}\\OperatorTok{.}\\FunctionTok{out}\\OperatorTok{.}\\FunctionTok{println}\\OperatorTok{(}\\NormalTok{arg}\\OperatorTok{);}
                  \\ControlFlowTok{if} \\OperatorTok{(}\\NormalTok{arg}\\OperatorTok{.}\\FunctionTok{equals}\\OperatorTok{(}\\StringTok{"foo"}\\OperatorTok{))}
                      \\ControlFlowTok{throw} \\KeywordTok{new} \\BuiltInTok{NoSuchElementException}\\OperatorTok{();}
              \\OperatorTok{\\}}
          \\OperatorTok{\\}}
      \\OperatorTok{\\}}
      \\end{Highlighting}
      \\end{Shaded}

      \\end{document}
    EOF
    actual_out = shell_output("#{bin/"skylighting"} -f latex #{testpath/"Test.java"}")
    assert_equal actual_out.strip, expected_out.strip
  end
end
