;;; babble-mode.el ---

;; Copyright (C) 2021 YK Goon

;; Author: YK Goon <ykgoon@gmail.com>
;; Version: 0.1

;; This file is not part of GNU Emacs.

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; babble-mode

;;; Code:
(defun run-with-local-idle-timer (secs repeat function &rest args)
  "Like `run-with-idle-timer', but always runs in the `current-buffer'.
Cancels itself, if this buffer was killed."
  (let* (;; Chicken and egg problem.
         (fns (make-symbol "local-idle-timer"))
         (timer (apply 'run-with-idle-timer secs repeat fns args))
         (fn `(lambda (&rest args)
                (if (not (buffer-live-p ,(current-buffer)))
                    (cancel-timer ,timer)
                  (with-current-buffer ,(current-buffer)
                    (apply (function ,function) args))))))
    (fset fns fn)
    fn))

(defun clear-and-center ()
  (erase-buffer)
  (dotimes (number (/ (window-height) 2))
    (insert "\n"))
  (end-of-buffer)
  ;; (dotimes (number (/ (window-width) 2))
  ;;   (insert " "))
  )

(define-derived-mode babble-mode text-mode "Babble"
  "The thing you do before pruning"
  (clear-and-center)
  (run-with-local-idle-timer 6 1 'clear-and-center))

(provide 'babble-mode)

;;; babble-mode.el ends here
