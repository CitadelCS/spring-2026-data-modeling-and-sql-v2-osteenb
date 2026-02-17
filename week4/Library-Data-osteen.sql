/* ------------------------------------------------------------
   File: Library-Data-osteen.sql
   Purpose: Insert sample data (3 rows per table)
   DB: PostgreSQL
------------------------------------------------------------ */

-- -------------------------
-- PUBLISHER
-- -------------------------
INSERT INTO library.publisher (name, address, phone) VALUES
                                                 ('Pearson Publishing', '123 Main St, New York, NY', '212-555-1000'),
                                                 ('McGraw Hill', '456 Market St, Boston, MA', '617-555-2000'),
                                                 ('OReilly Media', '789 Tech Ave, Sebastopol, CA', '707-555-3000');


-- -------------------------
-- BOOK
-- -------------------------
-- Identity column (book_id) auto-generates
INSERT INTO library.book (title, publisher_name) VALUES
                                             ('Database Systems Concepts', 'Pearson Publishing'),
                                             ('Introduction to Algorithms', 'McGraw Hill'),
                                             ('Learning PostgreSQL', 'OReilly Media');


-- -------------------------
-- BOOK_AUTHORS
-- -------------------------
-- Assumes book_id values are 1, 2, 3 (first inserts)
INSERT INTO library.book_authors (book_id, author_name) VALUES
                                                    (1, 'Abraham Silberschatz'),
                                                    (2, 'Thomas H. Cormen'),
                                                    (3, 'Regina Obe');


-- -------------------------
-- LIBRARY_BRANCH
-- -------------------------
INSERT INTO library.library_branch (branch_name, address) VALUES
                                                      ('Downtown Branch', '10 Center Plaza, Cityville'),
                                                      ('North Branch', '25 North Rd, Cityville'),
                                                      ('South Branch', '50 South Rd, Cityville');


-- -------------------------
-- BORROWER
-- -------------------------
INSERT INTO library.borrower (name, address, phone) VALUES
                                                ('John Smith', '100 Elm St', '555-1111'),
                                                ('Mary Johnson', '200 Oak St', '555-2222'),
                                                ('David Lee', '300 Pine St', '555-3333');


-- -------------------------
-- BOOK_COPIES
-- -------------------------
-- Assumes branch_id values are 1, 2, 3
INSERT INTO library.book_copies (book_id, branch_id, no_of_copies) VALUES
                                                               (1, 1, 5),
                                                               (2, 2, 3),
                                                               (3, 3, 4);


-- -------------------------
-- BOOK_LOANS
-- -------------------------
-- Assumes card_no values are 1, 2, 3
INSERT INTO library.book_loans (book_id, branch_id, card_no, date_out, due_date) VALUES
                                                                             (1, 1, 1, '2026-02-01', '2026-02-15'),
                                                                             (2, 2, 2, '2026-02-05', '2026-02-19'),
                                                                             (3, 3, 3, '2026-02-10', '2026-02-24');

