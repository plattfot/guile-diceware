(use-modules
  (guix packages)
  ((guix licenses) #:prefix license:)
  (guix download)
  (guix build-system gnu)
  (gnu packages)
  (gnu packages autotools)
  (gnu packages guile)
  (gnu packages guile-xyz)
  (gnu packages pkg-config)
  (gnu packages texinfo))

(package
  (name "guile-diceware")
  (version "0.1.1")
  (source "./guile-diceware-0.1.1.tar.gz")
  (build-system gnu-build-system)
  (arguments
    `(#:modules
      ((ice-9 match)
       (ice-9 ftw)
       ,@%gnu-build-system-modules)
      #:phases
      (modify-phases
        %standard-phases
        (add-after
          'install
          'hall-wrap-binaries
          (lambda* (#:key inputs outputs #:allow-other-keys)
            (let* ((compiled-dir
                     (lambda (out version)
                       (string-append
                         out
                         "/lib/guile/"
                         version
                         "/site-ccache")))
                   (uncompiled-dir
                     (lambda (out version)
                       (string-append
                         out
                         "/share/guile/site"
                         (if (string-null? version) "" "/")
                         version)))
                   (dep-path
                     (lambda (env modules path)
                       (list env
                             ":"
                             'prefix
                             (cons modules
                                   (map (lambda (input)
                                          (string-append
                                            (assoc-ref inputs input)
                                            path))
                                        ,''())))))
                   (out (assoc-ref outputs "out"))
                   (bin (string-append out "/bin/"))
                   (site (uncompiled-dir out "")))
              (match (scandir site)
                     (("." ".." version)
                      (for-each
                        (lambda (file)
                          (wrap-program
                            (string-append bin file)
                            (dep-path
                              "GUILE_LOAD_PATH"
                              (uncompiled-dir out version)
                              (uncompiled-dir "" version))
                            (dep-path
                              "GUILE_LOAD_COMPILED_PATH"
                              (compiled-dir out version)
                              (compiled-dir "" version))))
                        ,''("diceware"))
                      #t))))))))
  (native-inputs
    `(("autoconf" ,autoconf)
      ("automake" ,automake)
      ("pkg-config" ,pkg-config)
      ("texinfo" ,texinfo)))
  (inputs `(("guile" ,guile-3.0)))
  (propagated-inputs `())
  (synopsis "")
  (description "")
  (home-page "")
  (license license:gpl3+))

