(define (caar x) (car (car x)))
(define (cadr x) (car (cdr x)))
(define (cdar x) (cdr (car x)))
(define (cddr x) (cdr (cdr x)))

; Some utility functions that you may find useful to implement

(define (zip pairs) (list (map car pairs) (map cadr pairs)))



;; Problem 15
;; Returns a list of two-element lists
(define (enumerate s)
  ; BEGIN PROBLEM 15
    (define (helper s i)                                         ; For example 'scm> (enumerate '(3 4 5 6))' gives '((0 3) (1 4) (2 5) (3 6))'.
      (if (null? s) s                                            ; 'null?' returns true, '#t', if s is a nil or empty list and false, '#f', otherwise
          (cons (list i (car s)) (helper (cdr s) (+ i 1)))))     ; 'cons' builds pairs, 'car' will return the first item in the list. 'cdr' will return a list excluding the first element, 
    (helper s 0)                                                 ; 'list' gives a list.
  )
  ; END PROBLEM 15

;; Problem 16

;; Merge two lists LIST1 and LIST2 according to COMP and return
;; the merged lists.
(define (merge comp list1 list2)                 ; for example 'scm> (merge < '(1 4 6) '(2 5 8))' gives '(1 2 4 5 6 8)'.
  ; BEGIN PROBLEM 16
  (cond
    ((equal? list1 nil)                          ; 'equal?' returns true, '#t', if two lists are equal and false, '#f', otherwise.
    list2)                   
    ((equal? list2 nil) 
    list1)
    ((comp (car list1)(car list2))                          ; 'comp' is a comparator operator inputted into merge like '>' or '<',
    (cons (car list1)(merge comp (cdr list1) list2)))       ; ranking our list in decreasing and increasing order respectively.
    (else 
    (cons (car list2)(merge comp list1 (cdr list2)))))
  )
  ; END PROBLEM 16


(merge < '(1 5 7 9) '(4 8 10))
; expect (1 4 5 7 8 9 10)
(merge > '(9 7 5 1) '(10 8 4 3))
; expect (10 9 8 7 5 4 3 1)

;; Problem 17

(define (nondecreaselist s)                            ; Define a function nondecreaselist, which takes in a scheme list of numbers and outputs a list of lists, which overall has the  
    ; BEGIN PROBLEM 17                                 ; same numbers in the same order, but grouped into lists that are non-decreasing.
  (cond                                                ; for exaple 'scm> (nondecreaselist '(1 2 3 4 1 2 3 4 1 1 1 2 1 1 0 4 3 2 1))' gives
    ((equal? (cdr s) nil)                              ; '((1 2 3 4) (1 2 3 4) (1 1 1 2) (1 1) (0 4) (3) (2) (1))'.
    (cons s nil))
    ((> (car s) (cadr s))
    (cons (cons (car s) nil) (nondecreaselist (cdr s))))
    (else
    (cons (cons (car s) (car (nondecreaselist (cdr s)))) (cdr (nondecreaselist (cdr s))))))
  )
    ; END PROBLEM 17

;; Problem EC
;; Returns a function that checks if an expression is the special form FORM
(define (check-special form)
  (lambda (expr) (equal? form (car expr))))

(define lambda? (check-special 'lambda))
(define define? (check-special 'define))
(define quoted? (check-special 'quote))
(define let?    (check-special 'let))



;; Converts all let special forms in EXPR into equivalent forms using lambda
(define (let-to-lambda expr)                                                        ; 'let' can be interpreted as a special use of lambda (which is also in scheme),
  (cond ((atom? expr)                                                               ; for example 'scm> (let ((x 1) (y 2)) (+ x y))' is equivalent to '((lambda (x y) (+ x y)) 1 2)'.
         ; BEGIN PROBLEM EC
         expr
         ; END PROBLEM EC
         )
        ((quoted? expr)
         ; BEGIN PROBLEM EC
         expr
         ; END PROBLEM EC                                  
         )
        ((or (lambda? expr)
             (define? expr))
         (let ((form   (car expr))                         
               (params (cadr expr))                        
               (body   (cddr expr)))
           ; BEGIN PROBLEM EC
          (cons form (cons params (map let-to-lambda body)))             ; Map will take as argument one procedure and one or more lists. The procedure will be called once for             
           ; END PROBLEM EC                                              ; each position of the lists, using as arguments the list of elements at that position,   
           ))                                                            ; for example 'scm> (map + '( 1  2  3) '(10 20 30))' gives '(11 22 33)'.
                                                                         
                                                                         
                                                                         ; We 'map let-to-lambda body' just in case there is a let expression inside of body. 
        
        
        
        
        
        ((let? expr)                                                        
         (let ((values (cadr expr))
               (body   (cddr expr)))
           ; BEGIN PROBLEM EC
           (define form (car (zip values)))                                    ; 'zip' splits even indexed elements and odd indexed elements and is defined at the top of the page,
           (define params (map let-to-lambda (cadr (zip values))))             ; for example 'scm> (zip '((1 2) (3 4) (5 6)))' gives '((1 3 5) (2 4 6))'
           (define body (map let-to-lambda body))                             
           (cons (append (list 'lambda form) body) params)                     ; 'append' adds two lists together        
           ; END PROBLEM EC                                                    ; for example 'scm> (append '(1 2 3) '(4 5 6))' gives us '(1 2 3 4 5 6)'.
           ))               
        (else
         ; BEGIN PROBLEM EC
         (map let-to-lambda expr)
         ; END PROBLEM EC
         )))


