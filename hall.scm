(hall-description
  (name "diceware")
  (prefix "guile")
  (version "0.1.1")
  (author "Fredrik Salomonsson")
  (copyright (2020))
  (synopsis "")
  (description "")
  (home-page "")
  (license gpl3+)
  (dependencies `())
  (files (libraries
           ((scheme-file "diceware")
            (directory "diceware" ())))
         (tests ((directory "tests" ())))
         (programs
           ((directory "scripts" ((in-file "diceware")))))
         (documentation
           ((org-file "README")
            (symlink "README" "README.org")
            (text-file "HACKING")
            (text-file "COPYING")
            (directory "doc" ((texi-file "diceware")))))
         (infrastructure
           ((scheme-file "guix") (scheme-file "hall")))))
