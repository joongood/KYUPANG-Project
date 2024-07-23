<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<body>
  <!-- Main Sidebar Container -->
  <aside class="main-sidebar sidebar-dark-primary elevation-4">
    <!-- Brand Logo -->
    <a href="/" class="brand-link">
      <img src="/img/logo.png" alt="AdminLTE Logo" style="width: 80px; height: 50px;">
      <br>
      <span class="brand-text font-weight-light" style="padding-left:40px;">Admin Page</span>
    </a>

    <!-- Sidebar -->
    <div class="sidebar">
      <!-- Sidebar user panel (optional) -->
      <div class="user-panel mt-3 pb-3 mb-3 d-flex">
        <div class="info">
          <a href="/mutual/mutualMain" class="d-block">${sessionScope.label }님 환영합니다.</a>
        </div>
      </div>
      <!-- SidebarSearch Form -->
      <div class="form-inline">
        <div class="input-group" data-widget="sidebar-search">
          <input class="form-control form-control-sidebar" type="search" placeholder="Search" aria-label="Search">
          <div class="input-group-append">
            <button class="btn btn-sidebar">
              <i class="fas fa-search fa-fw"></i>
            </button>
          </div>
        </div>
      </div>
      <!-- Sidebar Menu -->
      <nav class="mt-2">
        <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
          <!-- Add icons to the links using the .nav-icon class
               with font-awesome or any other icon font library -->
          <li class="nav-item menu-open">
            <a href="/mutual/mutualMain" class="nav-link">
              <i class="nav-icon fas fa-tachometer-alt"></i>
              <p>
                대쉬보드
              </p>
            </a>
          </li>
          <li class="nav-item">
            <a href="#" class="nav-link">
              <i class="nav-icon fas fa-th"></i>
              <p>
                관리기능
         		<i class="right fas fa-angle-left"></i>
              </p>
            </a>
            <ul class="nav nav-treeview">
              <li class="nav-item">
                <a href="/mutual/manageProduct/listProduct" class="nav-link active">
                  <i class="far fa-circle nav-icon"></i>
                  <p>상품등록 및 관리</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="/mutual/manageMutual/modifyMutual" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>정보수정</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="/mutual/manageBanner/listBanner" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>배너신청</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="/mutual/manageCal/listCal" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>정산신청 및 거래관리</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="/mutual/manageUser/listUser" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>ID관리 및 생성</p>
                </a>
              </li>
            </ul>
          </li>
          <li class="nav-item">
            <a href="/mutual/calendar" class="nav-link">
              <i class="nav-icon far fa-calendar-alt"></i>
              <p>
                달력
              </p>
            </a>
          </li>
        </ul>
      </nav>
      <!-- /.sidebar-menu -->
    </div>
    <!-- /.sidebar -->
  </aside>
</body>
</html>