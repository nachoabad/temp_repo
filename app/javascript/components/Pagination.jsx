import React from "react";

export default function Pagination({ currentPage, totalPages, onPageChange }) {
  const pages = Array.from({ length: totalPages }, (_, i) => i + 1);

  return (
    <div>
      <button onClick={() => onPageChange(1)} disabled={currentPage === 1}>
        First
      </button>
      {currentPage > 1 && (
        <button onClick={() => onPageChange(currentPage - 1)} disabled={currentPage === 1}>
          Prev
        </button>
      )}

      {pages.map(page => (
        <button
          key={page}
          onClick={() => onPageChange(page)}
          disabled={currentPage === page}
          style={{ fontWeight: currentPage === page ? 'bold' : 'normal' }}
        >
          {page}
        </button>
      ))}

      {currentPage < totalPages && (
        <button onClick={() => onPageChange(currentPage + 1)} disabled={currentPage === totalPages}>
          Next
        </button>
      )}
      <button onClick={() => onPageChange(totalPages)} disabled={currentPage === totalPages}>
        Last
      </button>
    </div>
  );
}
