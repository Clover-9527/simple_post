package com.itz.model;

/**
 * 该类主要是起到对分页后的数据进行封装
 */
public class PageBean {

	private int pageCount; // 总页数
	private int pageSize = 10; // 分页中的数据条数
	private int currentPage = 1; // 当前页号
	private int totalRecords; // 总记录数
	private int beginIndex; // 分页起始记录号
	private int endIndex; // 分页结束记录号

	public PageBean() {

	}

	public PageBean(int currentPage, int pageSize, int totalRecords) {
		this.currentPage = currentPage;
		this.pageSize = pageSize;
		this.totalRecords = totalRecords;

		// 计算pageCount
		this.pageCount = (int) ((totalRecords + pageSize - 1) / pageSize);

		// 当前页是最后一页的情况，可能出现最后一页的数据小于pageSize
		if (pageCount == currentPage) {
			pageSize = totalRecords - (pageCount - 1) * pageSize;
		}

	}

	// 判断是否还有上一页
	public boolean isNextPage() {
		if (currentPage == pageCount) {
			return false;
		}
		return true;
	}

	// 判断是否还有下一页
	public boolean isPreviousPage() {
		if (currentPage == 1) {
			return false;
		}
		return true;
	}

	// 获取上一页
	public void goPreviousPage()
	{
		if (isPreviousPage())
		{
			currentPage--;
		}
	}

	// 获取下一页
	public void goNextPage()
	{
		if (isNextPage())
		{
			currentPage++;
		}
	}

	public int getBeginIndex() {
		// 计算beginIndex值
		beginIndex = (currentPage-1) * pageSize;
		return beginIndex;
	}

	public void setBeginIndex(int beginIndex) {
		this.beginIndex = beginIndex;
	}

	public int getEndIndex() {
		// 计算endIndex
		endIndex = currentPage * pageSize;
		return endIndex;
	}

	public void setEndIndex(int endIndex) {
		this.endIndex = endIndex;
	}

	public int getPageCount() {
		// 计算pageCount
		this.pageCount = (int) ((totalRecords + pageSize - 1) / pageSize);
		return pageCount;
	}

	public void setPageCount(int pageCount) {
		this.pageCount = pageCount;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public int getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}

	public int getTotalRecords() {
		return totalRecords;
	}

	public void setTotalRecords(int totalRecords) {
		this.totalRecords = totalRecords;
	}

}
