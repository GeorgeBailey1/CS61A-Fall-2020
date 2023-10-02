(define (split-at lst n)
  'YOUR-CODE-HERE
  (cond ((= n 0) (cons nil lst))
  ((null? lst) (cons lst nil))                                                                                      ;if list is empty returns an empty list
  (else (cons (cons (car lst) (car (split-at (cdr lst) (- n 1)))) (cdr (split-at (cdr lst) (- n 1))))))
)


(define (compose-all funcs)
  'YOUR-CODE-HERE
(lambda (x)
  (cond ((null? funcs) x)
  (else ((compose-all (cdr funcs)) ((car funcs) x)))))
)