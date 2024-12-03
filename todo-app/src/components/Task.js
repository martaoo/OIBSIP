import React from "react";
import { FaEdit, FaTrash, FaCheck } from "react-icons/fa";

const Task = ({ task, onEdit, onDelete, onComplete }) => {
  return (
    <div className="task">
      <h3>{task.title}</h3>
      <p>{task.description}</p>
      <p><small>Added: {new Date(task.createdAt).toLocaleString()}</small></p>
      {task.status === "Completed" && (
        <p><small>Completed: {new Date(task.completedAt).toLocaleString()}</small></p>
      )}
      <div className="task-actions">
        {task.status === "Pending" && (
          <button onClick={() => onComplete(task.id)}>
            <FaCheck /> Complete
          </button>
        )}
        <button onClick={() => onEdit(task.id)}>
          <FaEdit /> Edit
        </button>
        <button onClick={() => onDelete(task.id)}>
          <FaTrash /> Delete
        </button>
      </div>
    </div>
  );
};

export default Task;
