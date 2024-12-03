import React, { useState } from "react";
import AddTask from "./components/AddTask";
import TaskList from "./components/TaskList";

const App = () => {
  const [tasks, setTasks] = useState([]);

  const addTask = (task) => {
    setTasks([...tasks, { id: Date.now(), ...task }]);
  };

  const editTask = (id) => {
    const newTitle = prompt("Enter new title:");
    const newDescription = prompt("Enter new description:");
    setTasks(tasks.map(task =>
      task.id === id
        ? { ...task, title: newTitle || task.title, description: newDescription || task.description }
        : task
    ));
  };

  const deleteTask = (id) => {
    setTasks(tasks.filter(task => task.id !== id));
  };

  const completeTask = (id) => {
    setTasks(tasks.map(task =>
      task.id === id ? { ...task, status: "Completed", completedAt: new Date() } : task
    ));
  };

  const pendingTasks = tasks.filter(task => task.status === "Pending");
  const completedTasks = tasks.filter(task => task.status === "Completed");

  return (
    <div className="app">
      <h1>To-Do App</h1>
      <AddTask onAdd={addTask} />
      <h2>Pending Tasks</h2>
      <TaskList tasks={pendingTasks} onEdit={editTask} onDelete={deleteTask} onComplete={completeTask} />
      <h2>Completed Tasks</h2>
      <TaskList tasks={completedTasks} onEdit={editTask} onDelete={deleteTask} onComplete={completeTask} />
    </div>
  );
};

export default App;
