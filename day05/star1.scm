(use-modules (ice-9 textual-ports))

(define input-file (cadr (command-line)))

(define lines (list))
(call-with-input-file input-file
  (lambda (port)
    (do ((line (get-line port) (get-line port)))
      ((eof-object? line))
      (set! lines (append! lines (list line)))
    )
  )
)

(set! lines (map-in-order (lambda (line)
  (let ((splits (string-split line (string->char-set " ->"))))
    (let ((splits-cleaned (filter (lambda (e) (not (string-null? e))) splits)))
      (let ((pairs (map-in-order (lambda (pair) (string-split pair #\,)) splits-cleaned)))
        (let ((number-pairs (map-in-order (lambda (string-pair) (map-in-order (lambda (str) (string->number str)) string-pair)) pairs)))
          number-pairs
        )
      )
    )
  )
) lines))

(define vents (make-hash-table))

(define (mark-pos pos)
  ; (display "Marking pos: ")(display pos)(newline)
  (if (not (hash-get-handle vents pos)) 
    (hash-set! vents pos 1)
    (hash-set! vents pos (1+ (cdr (hash-get-handle vents pos))))
  )
)

(define (process-start-end start end static dynamic pos)
  ; (display "process-start-end-x called; start: ")(display start)(display " ; end: ")(display end)(newline)
  (let mark ((dynamic-start-end (if (<= (dynamic start) (dynamic end)) (cons (dynamic start) (dynamic end)) (cons (dynamic end) (dynamic start)))))
    (when (<= (car dynamic-start-end) (cdr dynamic-start-end))
       (mark-pos (pos (car dynamic-start-end) (static start)))
       (mark (cons (+ (car dynamic-start-end) 1) (cdr dynamic-start-end)))
    )
  )
)

(define (process-line line)
  (let* ((start (car line)) (end (cadr line)))
    (if (eq? (car start) (car end))
      (process-start-end start end car cadr (lambda (dynamic static) (list static dynamic)))
      (when (eq? (cadr start) (cadr end))
        (process-start-end start end cadr car (lambda (dynamic static) (list dynamic static)))
      )
    )
  )
)

(for-each process-line lines)

; (for-each (lambda (elem)
;   (display elem)(newline)
; ) lines)

; (display vents)(newline)

(define result (hash-count (lambda (_ value) (> value 1)) vents))
(display "Overlaps of 2+ lines: ")(display result)(newline)
